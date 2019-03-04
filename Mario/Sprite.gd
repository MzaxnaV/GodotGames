extends Sprite

var CAMERA_SCROLL_SPEED = 40

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		flip_h = true
		position.x -= CAMERA_SCROLL_SPEED * delta
		$AnimationPlayer.current_animation = "walk"
	elif Input.is_action_pressed("ui_right"):
		flip_h = false
		position.x += CAMERA_SCROLL_SPEED * delta
		$AnimationPlayer.current_animation = "walk"
	else:
		$AnimationPlayer.current_animation = "idle"