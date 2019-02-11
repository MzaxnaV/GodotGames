extends "res://scripts/fsm/BaseState.gd"

signal finished

var board = null

var highlighted_tile = Vector2(0, 0)
var highlighted = false
var allow_swap = false
var exit_game = false
var block_input = false
var next_level = false
var score_goal = null
var score = null
var level = null
var time = null

func _ready():
	$HUD/PlayHud.hide()

func enter(params):
	board = params
	score_goal = 150
	score = 0
	level = 1
	time = 15
	add_child(board)
	$HUD/PlayHud.show()
	start_level()

func exit():
	if block_input:
		yield(self, "finished")
	$HUD/PlayHud.hide()
	board.queue_free()
	return score

func start_level():
	if block_input:
		yield(self, "finished")
	init_level(level)
	$HUD/PlayHud/LevelIndicator/AnimateTime.start()
	$HUD/PlayHud/InfoBackground.hide()
	$HUD/PlayHud/Info.hide()

	$TweenLevel.interpolate_property($HUD/PlayHud/LevelIndicator, 'position', Vector2(0, -40), Vector2(0, 108), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$TweenLevel.interpolate_property($HUD/PlayHud/LevelIndicator, 'position', Vector2(0, 108), Vector2(0, 288), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, 1)

	if level != 1:
		board.clear_board()
		board.generate_board()

	$TweenLevel.start()

func victory():
	$VictorySound.play()
	$TweenAlpha.interpolate_property($HUD/Alpha, 'self_modulate', Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenAlpha.interpolate_property($HUD/Alpha, 'self_modulate', Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)
	level += 1
	$HUD/PlayHud/Info/Timer/LevelTimer.stop()
	start_level()
	$TweenAlpha.start()

func init_level(level):
	block_input = true
	score_goal = int(score_goal * 1.5)
	$HUD/PlayHud/LevelIndicator/LevelText.text = "Level " + str(level) 
	$HUD/PlayHud/Info/Level.text = "Level " + str(level)
	$HUD/PlayHud/Info/Goal.text = "Goal " + str(score_goal)
	$HUD/PlayHud/Info/Score.text = "Score " + str(score)
	$HUD/PlayHud/Info/Timer.text = "Timer " + str(level * 15)
	$HUD/PlayHud/Info/Timer/LevelTimer.wait_time = time + 2 * level

func handle_event(event):
	if !block_input:
		if highlighted:
			highlighted_tile.x = int(board.get_highlighted().x)
			highlighted_tile.y = int(board.get_highlighted().y)

			if event.is_action_released("ui_up"):
				if highlighted_tile.y > 0:
					highlighted_tile.y -= 1
			elif event.is_action_released("ui_down"):
				if highlighted_tile.y < board.size - 1:
					highlighted_tile.y += 1
			elif event.is_action_released("ui_left"):
				if highlighted_tile.x > 0:
					highlighted_tile.x -= 1
			elif event.is_action_released("ui_right"):
				if highlighted_tile.x < board.size - 1:
					highlighted_tile.x += 1

			board.move_highlight(highlighted_tile * 32)

		if event.is_action_released("ui_accept"):
			block_input = true
			if not highlighted:
				highlighted = true
				board.move_highlight(highlighted_tile * 32)
			else:
				if allow_swap:
					if (highlighted_tile - board.get_selected()).length() <= 1:
						board.swap(highlighted_tile)
						board.hide_highlight()
						while board != null and board.calculate_matches():
							score += board.matches.size() * 15
							$MatchSound.play()
							if score >= score_goal:
								victory()
								break
							$HUD/PlayHud/Info/Score.text = "Score " + str(score)
							board.remove_matches()
							yield(get_tree().create_timer(0.05), "timeout")
							board.fall_tiles()
							yield(get_tree().create_timer(0.5), "timeout")
						self.emit_signal("finished")
					else:
						allow_swap = !allow_swap
						$ErrorSound.play()
				else:
					board.select(highlighted_tile * 32)
				allow_swap = !allow_swap
			board.show_highlight()
			block_input = false

func _on_AnimateTime_timeout():
	block_input = false
	highlighted = true
	board.show_highlight()
	$HUD/PlayHud/InfoBackground.show()
	$HUD/PlayHud/Info.show()
	$HUD/PlayHud/Info/Timer/LevelTimer.start()

func _on_LevelTimer_timeout():
	get_parent().change_state('game-over')