extends Node2D

var board_size = 8

var Tile = preload('res://scenes/Tile.tscn')

func generate_board():
	randomize()
	for y in range(board_size):
		for x in range(board_size):
			var tile = Tile.instance()
			tile.init(randi() % 108)
			tile.position = Vector2(x * 32, y * 32)
			add_child(tile)