extends "res://Scripts/states/BaseState.gd"

func enter(params):
	$StartScreen.show()
	$StartScreen.get_child(1).get_child(0).grab_focus()

func exit():
	$StartScreen.hide()

func handle_event(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()