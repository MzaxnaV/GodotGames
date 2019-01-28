extends "res://scripts/fsm/BaseState.gd"

var board = null

func enter(params):
	board = params
	add_child(board)

func exit():
	remove_child(board)
	return board

func update_physics(delta):
	pass

func update(delta):
	pass

func handle_event(event):
	pass