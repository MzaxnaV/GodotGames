extends "res://State.gd"

func enter(params):
	$ScoreScreen.show()
	$ScoreScreen/Score.text = "Score: " + str(params)

func exit():
	$ScoreScreen.hide()

func handle_event(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().change_state('count')
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()