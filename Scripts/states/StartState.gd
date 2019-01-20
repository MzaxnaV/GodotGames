extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")

func enter(params):
	$StartScreen.show()
	$StartScreen.get_child(1).get_child(0).grab_focus()

func exit():
	$StartScreen.hide()
	var level = Level.instance()
	var paddle_skin = 1
	var l = 1
	level.populate(l, paddle_skin)
	return level
