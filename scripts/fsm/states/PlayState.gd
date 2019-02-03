extends "res://scripts/fsm/BaseState.gd"

var board = null

var selected_tile = null
var highlighted = false
var allow_swap = false

func enter(params):
	board = params
	add_child(board)
	selected_tile = Vector2(0, 0)

func exit():
	board.queue_free()

func handle_event(event):
	if highlighted:
		var x = selected_tile.x
		var y = selected_tile.y

		if event.is_action_released("ui_up"):
			if y > 0:
				selected_tile.y -= 1
		elif event.is_action_released("ui_down"):
			if y < board.size - 1:
				selected_tile.y += 1
		elif event.is_action_released("ui_left"):
			if x > 0:
				selected_tile.x -= 1
		elif event.is_action_released("ui_right"):
			if x < board.size - 1:
				selected_tile.x += 1

		board.highlight(selected_tile * 32)

	if event.is_action_released("ui_accept"):
		if not highlighted:
			highlighted = true
			board.highlight(selected_tile * 32)
		else:
			if allow_swap:
				board.swap()
			else:
				board.select(selected_tile * 32)

			allow_swap = !allow_swap

	if event.is_action_released("debug_a"):
		if board.calculate_matches():
			board.remove_matches()
	elif event.is_action_released("debug_b"):
		board.fall_tiles()