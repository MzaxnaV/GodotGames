extends "res://State.gd"

var count = 3

func enter(params):
	$CountDownScreen/CountDown.text = str(count)
	$CountDownScreen/CountDown.show()
	$CountDownScreen/Timer.start()

func exit():
	count = 3
	$CountDownScreen/CountDown.hide()
	$CountDownScreen/Timer.stop()

func update(delta):
	if count < 1:
		get_parent().change_state('play')

func _on_Timer_timeout():
	count -= 1
	$CountDownScreen/CountDown.text = str(count)
