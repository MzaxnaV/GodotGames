extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")
var Ball = preload("res://Scenes/Ball.tscn")
var Paddle = preload("res://Scenes/Paddle.tscn")
var Brick =  preload("res://Scenes/Brick.tscn")

var ball = null
var paddle = null
var bricksdata = []
var skin = 0

export var posbyColour = [
	Vector2(0, 0),
	Vector2(4*32, 0),
	Vector2(2*32, 16),
	Vector2(0, 32),
	Vector2(4*32, 32)
]

func enter(params):
	generate_map()

func exit():
	var paddlepos = paddle.position
	return { 'bricksdata' : bricksdata, 'paddle' : paddlepos}

	for child in get_children():
		child.queue_free()

func generate_map():
	var ball = Ball.instance()
	ball.position.y = -8 - 4
	var paddle = Paddle.instance()
	paddle.add_child(ball)
	add_child(paddle)

	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7

	for y in range(1, num_rows+1):
		for x in range(1, num_cols+1):
			var brick = Brick.instance()
			brick.init(posbyColour[skin], (x-1) * 32 + 8 + (13 - num_cols) * 16 + 16, y * 16)
			bricksdata.append({ brick.position : posbyColour[skin] })
			add_child(brick)