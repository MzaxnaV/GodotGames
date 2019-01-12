extends Node

var brick = null
onready var brick_sound = $BrickHitSound

export var posbyColour = [
	Vector2(0, 0),
	Vector2(4*32, 0),
	Vector2(2*32, 16),
	Vector2(0, 32),
	Vector2(4*32, 32)
]

var Brick = preload("res://Scenes/Brick.tscn")

func generate_map():
	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7

	for y in range(1, num_rows+1):
		for x in range(1, num_cols+1):
			brick = Brick.instance()
			brick.init(posbyColour[0],
				(x-1) * 32 + 8 + (13 - num_cols) * 16 + 16,
				y * 16)
			add_child(brick)