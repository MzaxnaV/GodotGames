extends "res://scripts/fsm/BaseState.gd"

var board = null

func enter(params):
	board = params
	add_child(board)

func exit():
	pass

func update_physics(delta):
	pass

func update(delta):
	pass

func handle_event(event):
	pass