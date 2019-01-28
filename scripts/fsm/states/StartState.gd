extends "res://scripts/fsm/BaseState.gd"

var Board = preload("res://scenes/Board.tscn")
var board = null

func enter(params):
	$StartScreen.show()
	board = Board.instance()
	board.generate_board()
	board.position = Vector2(128, 16)
	$StartScreen.add_child(board)

func exit():
	$StartScreen.hide()
	$StartScreen.remove_child(board)
	return board

func handle_event(event):
	if event.is_action_released("ui_accept"):
		get_parent().change_state('play')