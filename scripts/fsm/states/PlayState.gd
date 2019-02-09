extends "res://scripts/fsm/BaseState.gd"

var board = null

var selected_tile = Vector2(0, 0)
var highlighted = false
var allow_swap = false
var block_input = true

func enter(params):
	board = params
	add_child(board)
	block_input = false

func exit():
	board.queue_free()

func handle_event(event):
	if !block_input:
		if highlighted:
			selected_tile.x = int(board.get_selected().x)
			selected_tile.y = int(board.get_selected().y)

			if event.is_action_released("ui_up"):
				if selected_tile.y > 0:
					selected_tile.y -= 1
			elif event.is_action_released("ui_down"):
				if selected_tile.y < board.size - 1:
					selected_tile.y += 1
			elif event.is_action_released("ui_left"):
				if selected_tile.x > 0:
					selected_tile.x -= 1
			elif event.is_action_released("ui_right"):
				if selected_tile.x < board.size - 1:
					selected_tile.x += 1

			board.move_highlight(selected_tile * 32)

		if event.is_action_released("ui_accept"):
			block_input = true
			if not highlighted:
				highlighted = true
				board.move_highlight(selected_tile * 32)
			else:
				if allow_swap:
					board.swap(selected_tile)
					board.hide_highlight()
					while board.calculate_matches():
						board.remove_matches()
						yield(get_tree().create_timer(0.05), "timeout")
						board.fall_tiles()
						yield(get_tree().create_timer(0.5), "timeout")
				else:
					board.select(selected_tile * 32)
				allow_swap = !allow_swap
			board.show_highlight()
			block_input = false