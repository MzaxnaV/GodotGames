extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")

var paddle_skin = 1

func enter(params):
	$PaddleSelectScreen.show()
	set_buttons_tint()

func exit():
	var level = Level.instance()
	var l = 1
	level.populate(l, paddle_skin)
	$PaddleSelectScreen.hide()
	return level

func handle_event(event):
	if event.is_action_pressed("ui_right"):
		paddle_skin += 1
		if paddle_skin > 4:
			paddle_skin = 4
			$NoSelectSound.play()
		else:
			$SelectSound.play()
	elif event.is_action_pressed("ui_left"):
		paddle_skin -= 1
		if paddle_skin < 1:
			paddle_skin = 1
			$NoSelectSound.play()
		else:
			$SelectSound.play()
	elif event.is_action_pressed("ui_accept"):
		get_parent().change_state('serve')

	set_buttons_tint()

	$PaddleSelectScreen/Paddle.set_region_rect(Rect2(32, 32 + 32 * paddle_skin, 32 * 2, 16))

func set_buttons_tint():
	if paddle_skin == 1:
		$PaddleSelectScreen/LeftSelection.modulate = Color(40/255.0, 40/255.0, 40/255.0, 1-40/255.0)
	else:
		$PaddleSelectScreen/LeftSelection.modulate = Color(1, 1, 1, 1)

	if paddle_skin == 4:
		$PaddleSelectScreen/RightSelection.modulate = Color(40/255.0, 40/255.0, 40/255.0, 1-40/255.0)
	else:
		$PaddleSelectScreen/RightSelection.modulate = Color(1, 1, 1, 1)