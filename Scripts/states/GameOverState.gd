extends "res://Scripts/states/BaseState.gd"

var score = 0

func enter(params):
	$GameOverScreen/ScoreText.text = "Final Score: " + str(params.score)
	$GameOverScreen.show()

func exit():
	$GameOverScreen.hide()

func handle_event(event):
	if event.is_action_released("ui_accept"):
		get_parent().change_state('start')