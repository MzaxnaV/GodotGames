extends Node2D

var size = 8
var tiles = []
var matches = []

const RED = Color(1, 0.25, 0.25, 1)
const INACTIVE_RED = Color(0.75, 0.25, 0.25, 1)

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

func show_highlight():
	$Highlight.show()
	$Highlight.modulate = RED

func move_highlight(pos):
	$Highlight.position = pos

func hide_highlight():
	$Highlight.modulate = INACTIVE_RED

func get_tile(x, y):
	print(tiles[x + y * 8].get_ref().position)
	return tiles[x + y * 8]

func select(pos):
	$Select.position = pos
	$Select.show()

func deselect():
	$Select.hide()

func get_selected():
	return $Highlight.position / 32

func swap(pos):
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

func fall_tiles():
	for x in range(size):
		var space = false
		var spaceY = -1
		var y = size - 1
		while y >= 0:
			var tile = tiles[x + y * 8]
			if space:
				if tile != null && tile.get_ref():
					tiles[x + spaceY * 8] = tile
					tiles[x + y * 8] = null
					$Tween.interpolate_property(tile.get_ref(), 'position', Vector2(x, y) * 32, Vector2(x, spaceY) * 32, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
					space = false
					y = spaceY
					spaceY = -1
			elif tile == null || !tile.get_ref():
				space = true
				if spaceY == -1:
					spaceY = y
			y -= 1

	# create replacement tiles
	for x in range(size):
		for y in range(size-1, -1, -1):
			if tiles[x + y * 8] == null || !tiles[x + y * 8].get_ref():
				var tile = Tile.instance()
				tile.init(Vector2(0, 0), 1 + randi() % 9, 1)
				add_child(tile)
				tiles[x + y * 8] = weakref(tile)
				$Tween.interpolate_property(tile, 'position', Vector2(x, y-size) * 32, Vector2(x, y) * 32, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)

	$Tween.start()

func remove_matches():
	for tile in matches:
		tile.get_ref().queue_free()
	matches = []

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
				matches.append(tiles[x + (7 - i) * 8])

	self.matches = matches
	return matches.size() > 0