extends Area2D

var skin = 1
var size = 2

var speed = 0

func _ready():
	change_paddle()

func _input(event):
	if event.is_action_pressed("ui_left"):
		speed = -CONSTANTS.PADDLE_SPEED
	elif event.is_action_pressed("ui_right"):
		speed = CONSTANTS.PADDLE_SPEED

	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		speed = 0

func _process(delta):
	position.x += speed * delta

func change_paddle():
	var x = 0
	var y = 32 + 32 * skin

	if size > 3:
		y += 16
	else:
		x = 32 * (size-1) * (size) / 2

	$paddle.set_region_rect(Rect2(x, y, 32 * size, 16))
	$CollisionShape2D.get_shape().set_extents(Vector2(16 * size, 8))