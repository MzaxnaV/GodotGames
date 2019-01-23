extends "res://Scripts/states/BaseState.gd"

func enter(params):
	$HighscoreScreen.show()
	check_highscore(params.score)

func handle_event(event):
	if event.is_action_released('ui_cancel'):
		$WallHitSound.play()
		get_parent().change_state('start')

func hide():
	$HighscoreScreen.hide()

func check_highscore(score):
	if score != null:
		print("update highscore")
		CONSTANTS.update_highscore()

	print("use CONSTANTS.hoghscore to render the scores")