extends "res://scripts/fsm/BaseState.gd"

var board = null
var time = 1

func enter(params):
	board = params
	$Timer.start()
	$Tween.interpolate_property(params, 'position', Vector2(128, 16), Vector2(256-16, 16), time, Tween.TRANS_EXPO, Tween.EASE_OUT, time)
	$Tween.interpolate_property($White, 'self_modulate', Color(1, 1, 1, 0), Color(1, 1, 1, 1), time , Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property($White, 'self_modulate', Color(1, 1, 1, 1), Color(1, 1, 1, 0), time, Tween.TRANS_LINEAR, Tween.EASE_OUT, time)
	$Tween.start()
	add_child(board)

func exit():
	remove_child(board)
	return board

func _on_Timer_timeout():
	get_parent().change_state("play")
