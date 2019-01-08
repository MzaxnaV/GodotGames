extends "res://Scripts/states/BaseState.gd"

func enter(params):
	$StartScreen.show()

func exit():
	$StartScreen.hide()

func handle_event(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()