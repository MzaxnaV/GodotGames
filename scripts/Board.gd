extends Node2D

var size = 8

var tiles = []

var Tile = preload('res://scenes/Tile.tscn')

func generate_board():
	randomize()
	for y in range(size):
		for x in range(size):
			var tile = Tile.instance()
			tile.init(randi() % 108)
			tile.position = Vector2(x * 32, y * 32)
			add_child(tile)
			tiles.append(tile)

func highlight(pos):
	$Highlight.show()
	$Highlight.position = pos

func get_tile(x, y):
	print(x, y, tiles[x + y * 8].position)
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

	#swap objects indices
	tiles[pos1.x/32 + 8*pos1.y/32] = tiles[pos2.x/32 + 8*pos2.y/32]
	tiles[pos2.x/32 + 8*pos2.y/32] = temp
	
	#fix their positions
	$Tween.interpolate_property(tiles[pos1.x/32 + 8*pos1.y/32], 'position', pos2, pos1, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property(tiles[pos2.x/32 + 8*pos2.y/32], 'position', pos1, pos2, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property($Highlight, 'position', pos1, pos2, 0.3, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
