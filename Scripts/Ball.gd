extends Area2D

var skin = 1
var velocity = null

func change_ball():
	var y = 48

	if skin > 4:
		y += 8

	$ball.set_region_rect(Rect2(96 + 8 * (skin - 1), y, 8, 8))

func reset(paddle):
	change_ball()

	position.x = CONSTANTS.VIRTUAL_WIDTH / 2 - 2
	position.y = paddle.position.y - 8 - 4

	velocity = Vector2(rand_range(-200, 200), rand_range(-50, -60)).normalized() * 200