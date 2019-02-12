extends "res://State.gd"

onready var Entities = preload("res://GameEntities.tscn")

var instance = null

func enter(params):
	instance = Entities.instance()
	get_parent().get_node("Parallax/Gamelayer").add_child(instance)
	instance.connect("exit_game", self, "_on_GameEntities_exit_game")

func exit():
	var score = instance.score
	instance.queue_free()
	return score

func _on_GameEntities_exit_game():
	$Explosion.play()
	$Hurt.play()
	get_parent().change_state('score')
