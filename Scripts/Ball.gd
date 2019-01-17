extends Area2D

var velocity = null
var skin = null

func _physics_process(delta):
	position += velocity * delta

func init():
	skin = randi() % 7 + 1
	change_ball()

func change_ball():
	var s = skin
	var y = 48

	if s > 4:
		s -= 4
		y += 8

	var rect = Rect2(96 + 8 * (s-1), y, 8, 8)
	$ball.set_region_rect(rect)

func reset(pos):
	change_ball()

	position.x = pos.x
	position.y = pos.y - 16

	velocity = Vector2(rand_range(-200, 200), rand_range(-50, -60)).normalized() * 200