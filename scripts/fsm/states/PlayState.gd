extends "res://scripts/fsm/BaseState.gd"

var board = null

var selected_tile = Vector2(0, 0)
var highlighted = false
var allow_swap = false
var block_input = null
var next_level = false

func enter(params):
	board = params
	$Tween.interpolate_property($HUD/PlayHud/LevelIndicator, 'position', Vector2(0, -40), Vector2(0, 108), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property($HUD/PlayHud/LevelIndicator, 'position', Vector2(0, 108), Vector2(0, 288), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 1)
	add_child(board)
	start_level(1)

func exit():
	board.queue_free()

func start_level(level):
	block_input = true
	$HUD/PlayHud/LevelIndicator/LevelText.text = "Level " + str(level) 
	$HUD/PlayHud/LevelIndicator/AnimateTime.start()
	$LevelTimer.wait_time = level * 15
	if level != 1:
		board.clear_board()
		board.generate_board()
	$Tween.start()

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

func _on_AnimateTime_timeout():
	block_input = false
	highlighted = true
	board.show_highlight()
	$LevelTimer.start()

func _on_LevelTimer_timeout():
	get_parent().change_state('game-over')
