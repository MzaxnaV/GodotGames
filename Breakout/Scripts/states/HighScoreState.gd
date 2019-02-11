extends "res://Scripts/states/BaseState.gd"

func enter(params):
	create_highscore_table()
	$HighscoreScreen.show()

func handle_event(event):
	if event.is_action_released('ui_cancel'):
		$WallHitSound.play()
		get_parent().change_state('start')

func exit():
	$HighscoreScreen.hide()

func create_highscore_table():
	var names = ""
	var scores = ""

	for highscore in CONSTANTS.highscores:
		names += highscore[0] + '\n'
		scores += str(highscore[1]) + '\n'

	$HighscoreScreen/names.text = names
	$HighscoreScreen/scores.text = scores
