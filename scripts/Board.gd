extends Node2D

var size = 8
var tiles = []
var matches = []

var Tile = preload('res://scenes/Tile.tscn')

func generate_tiles():
	randomize()
	for y in range(size):
		for x in range(size):
			var tile = Tile.instance()
			tile.init(Vector2(x * 32, y * 32), 1 + randi() % 9, 1)
			tiles.append(weakref(tile))

	while calculate_matches():
		for tile in tiles:
			tile.get_ref().free()
		tiles = []
		generate_tiles()

func generate_board():
	generate_tiles()

	for tile in tiles:
		add_child(tile.get_ref())

func highlight(pos):
	$Highlight.show()
	$Highlight.position = pos

func get_tile(x, y):
	print(tiles[x + y * 8].get_ref().position)
	return tiles[x + y * 8]

func select(pos):
	$Select.position = pos
	$Select.show()

func deselect():
	$Select.hide()

func swap():
	deselect()
	var pos1 = $Highlight.position
	var pos2 = $Select.position
	var temp = tiles[pos1.x/32 + 8*pos1.y/32]

	# swap objects indices
	tiles[pos1.x/32 + 8*pos1.y/32] = tiles[pos2.x/32 + 8*pos2.y/32]
	tiles[pos2.x/32 + 8*pos2.y/32] = temp
	
	# fix their positions
	$Tween.interpolate_property(tiles[pos1.x/32 + 8*pos1.y/32].get_ref(), 'position', pos2, pos1, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property(tiles[pos2.x/32 + 8*pos2.y/32].get_ref(), 'position', pos1, pos2, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property($Highlight, 'position', pos1, pos2, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()

func calculate_matches():
	var matches = []
	var match_num = 1

	# horizontal matches
	for y in range(size):
		var colour_to_match = tiles[8 * y].get_ref().colour
		match_num = 1

		for x in range(1, size):
			var index = x + 8 * y
			if tiles[index].get_ref().colour == colour_to_match:
				match_num += 1
			else:
				colour_to_match = tiles[index].get_ref().colour

				if match_num >= 3:
					for i in range(1, match_num + 1):
						matches.append(tiles[index - i])

				if x >= 7:
					break
				match_num = 1

		if match_num >= 3:
			for i in range(match_num):
				matches.append(tiles[6 - i + y * 8])

	# vertical matches
	for x in range(size):
		var colour_to_match = tiles[x].get_ref().colour
		match_num = 1

		for y in range(1, size):
			var index = x + 8 * y
			if tiles[index].get_ref().colour == colour_to_match:
				match_num += 1
			else:
				colour_to_match = tiles[index].get_ref().colour

				if match_num >= 3:
					for i in range(1, match_num + 1):
						matches.append(tiles[index - i * 8])

				if y >= 7:
					break
				match_num = 1

		if match_num >= 3:
			for i in range(match_num):
				matches.append(tiles[x + (6 - i) * 8])

	self.matches = matches
	return matches.size() > 0