extends "res://scripts/fsm/BaseState.gd"

var Board = preload("res://scenes/Board.tscn")
var board = null

func enter(params):
	$StartScreen.show()
	board = Board.instance()
	board.generate_board()
	board.position = Vector2(128, 16)
	$StartScreen.add_child(board)
	$StartScreen/Menu/MenuBackground/Options/Start.grab_focus()

func exit():
	$StartScreen.hide()
	$StartScreen.remove_child(board)
	return board

func _on_Start_button_down():
	get_parent().change_state('begin-game')

func _on_Quit_button_down():
	get_tree().quit()
