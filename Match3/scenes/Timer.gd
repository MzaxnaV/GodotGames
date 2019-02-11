extends Label

func _process(delta):
	set_text("Timer " + str(int($LevelTimer.time_left)))