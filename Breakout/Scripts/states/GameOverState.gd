extends "res://Scripts/states/BaseState.gd"

var score = 0
var index = null

func enter(params):
	$GameOverScreen/ScoreText.text = "Final Score: " + str(params.score)
	score = params.score
	params.queue_free()
	$GameOverScreen.show()

func exit():
	$GameOverScreen.hide()
	return index

func handle_event(event):
	if event.is_action_released("ui_accept"):
		if score < CONSTANTS.highscores.back()[1]:
			get_parent().change_state('start')
		else:
			var temp = score
			for i in range(10):
				if score > CONSTANTS.highscores[i][1]:
					index = i
					CONSTANTS.highscores.insert(i, ["---", score])
					break

			CONSTANTS.highscores.pop_back()
			get_parent().change_state('enterscore')