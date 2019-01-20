extends "res://Scripts/states/BaseState.gd"

var level = null

func enter(params):
	level = params
	level.set_play('playing')
	add_child(level)

func exit():
	remove_child(level)
	return level

func handle_event(event):
	if event.is_action_pressed("ui_select"):
		$PlayScreen/PauseSound.play()
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$PlayScreen.show()
		else:
			$PlayScreen.hide()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()