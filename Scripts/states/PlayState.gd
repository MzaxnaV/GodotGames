extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")

func enter(params):
	var level = Level.instance()
	level.connect("game_over", self, "_on_Level_game_over")
	add_child(level)

func exit():
	var score = get_child(0).score
	get_child(0).queue_free()
	return { 'score': str(score) }

func _on_Level_game_over():
	get_parent().change_state('gameover')
