extends "res://Scripts/states/BaseState.gd"

var level = null

func enter(params):
	level = params
	level.set_play('victory')
	$VictorySound.play()
	$ShowScreen.start()
	add_child(level)

func exit():
	remove_child(level)
	level.populate(level.level + 1, 0)
	return level

func _on_ShowScreen_timeout():
	get_parent().change_state('serve')
