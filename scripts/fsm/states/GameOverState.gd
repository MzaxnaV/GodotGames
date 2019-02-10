extends "res://scripts/fsm/BaseState.gd"

func enter(params):
	$GameOverInfo/Score.text = "Your Score\n" + str(params)
	$GameOverInfo.show()
	$GameOverInfoBackground.show()

func exit():
	$GameOverInfo.hide()
	$GameOverInfoBackground.hide()

func handle_event(event):
	if event.is_action_released("ui_accept"):
		get_parent().change_state("start")