extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")
var Brick = preload("res://Scenes/Brick.tscn")

var brick_skin = 1

export var posbyColour = [
	Vector2(0, 0),
	Vector2(4*32, 0),
	Vector2(2*32, 16),
	Vector2(0, 32),
	Vector2(4*32, 32)
]

func enter(params):
	$StartScreen.show()
	$StartScreen.get_child(1).get_child(0).grab_focus()

func exit():
	$StartScreen.hide()
	var level = Level.instance()
	var paddle_skin = 1
	level.populate(generate_bricks(), paddle_skin)
	return level

func generate_bricks():
	var bricks = []

	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7

	var brick = null
	for y in range(1, num_rows+1):
		for x in range(1, num_cols+1):
			brick = Brick.instance()
			brick.init(
				Vector2((x-1) * 32 + 8 + (13 - num_cols) * 16 + 16, y * 16 + 8),
				Rect2(posbyColour[brick_skin-1].x, posbyColour[brick_skin-1].y, 32, 16),
				brick_skin
			) 
			bricks.append(brick)

	return bricks