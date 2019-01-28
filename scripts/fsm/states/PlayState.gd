extends "res://scripts/fsm/BaseState.gd"

var board = null

var selected_tile = null
var highlighted = true

func enter(params):
	board = params
	add_child(board)
	selected_tile = board.get_tile(1, 1)

func exit():
	board.queue_free()

func handle_event(event):

	var x = selected_tile.position.x / 32 + 1
	var y = selected_tile.position.y / 32 + 1

	if event.is_action_released("ui_up"):
		if y > 1:
			selected_tile = board.get_tile(x, y - 1)
	elif event.is_action_released("ui_down"):
		if y < 8:
			selected_tile = board.get_tile(x, y + 1)
	elif event.is_action_released("ui_left"):
		if x > 1:
			selected_tile = board.get_tile(x - 1, y)
	elif event.is_action_released("ui_right"):
		if x < 8:
			selected_tile = board.get_tile(x + 1, y)
	elif event.is_action_released("ui_accept"):
		if not highlighted:
			highlighted = true

	if highlighted:
		board.highlight(selected_tile.position)