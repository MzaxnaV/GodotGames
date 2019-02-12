extends "res://State.gd"

func enter(params):
	$TitleScreen.visible = true

func exit():
	$TitleScreen.visible = false

func handle_event(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().change_state('count')