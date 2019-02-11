extends "res://Scripts/states/BaseState.gd"

var index = null
var active_button = null

func enter(params):
	if (params == null):
		print("EnterHighScoreState.gd: OKAY THIS SHOULDN'T HAPPEN")
	index = params
	$EnterHighScoreScreen/highscore.text = "Your score: " + str(CONSTANTS.highscores[params][1])
	$EnterHighScoreScreen/name/char1.grab_focus()
	$EnterHighScoreScreen.show()
	$HighScoreSound.play()

func exit():
	$EnterHighScoreScreen.hide()

func handle_event(event):
	if event.is_action_released('ui_accept'):
		CONSTANTS.highscores[index][0] = $EnterHighScoreScreen/name/char1.text + $EnterHighScoreScreen/name/char2.text + $EnterHighScoreScreen/name/char3.text
		CONSTANTS.save_highscores()
		get_parent().change_state('highscore')
		
	elif event.is_action_pressed('ui_up'):
		if active_button.text.ord_at(0) + 1 > 'Z'.ord_at(0):
			active_button.text = 'A'
		else:
			active_button.text = char(active_button.text.ord_at(0) + 1)
	elif event.is_action_pressed('ui_down'):
		if active_button.text.ord_at(0) - 1 < 'A'.ord_at(0):
			active_button.text = 'Z'
		else:
			active_button.text = char(active_button.text.ord_at(0) - 1)

func _on_char1_focus_entered():
	active_button = $EnterHighScoreScreen/name/char1


func _on_char2_focus_entered():
	active_button = $EnterHighScoreScreen/name/char2


func _on_char3_focus_entered():
	active_button = $EnterHighScoreScreen/name/char3
