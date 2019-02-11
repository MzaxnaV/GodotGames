extends "res://Scripts/states/BaseState.gd"

var level = null

func enter(params):
	level = params
	level.set_play('serving')
	add_child(level)

func handle_event(event):
	if event.is_action_released("ui_accept"):
		get_parent().change_state("play")

func exit():
	remove_child(level)
	return level