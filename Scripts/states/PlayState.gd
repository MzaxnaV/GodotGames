extends "res://Scripts/states/BaseState.gd"

var PlayScreen = preload("res://Scenes/PlayScreen.tscn")

func enter(params):
	add_child(PlayScreen.instance())

func exit():
	get_child(0).queue_free()

func handle_event(event):
	if event.is_action_pressed("ui_cancel"):
		get_parent().change_state('start')
