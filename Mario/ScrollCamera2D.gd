extends Camera2D

var CAMERA_SCROLL_SPEED = 40

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= CAMERA_SCROLL_SPEED * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += CAMERA_SCROLL_SPEED * delta