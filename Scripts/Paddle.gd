extends Area2D

var skin = 1
var size = 2

func _ready():
	change_paddle()

func change_paddle():
	var x = 0
	var y = 32 + 32 * skin

	if size > 3:
		y += 16
	else:
		x = 32 * (size-1) * (size) / 2

	$paddle.set_region_rect(Rect2(x, y, 32 * size, 16))
	$CollisionShape2D.get_shape().set_extents(Vector2(16 * size, 8))