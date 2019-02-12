extends Node

signal exit_game

var score = 0

onready var bird = $Bird

func _physics_process(delta):
	if bird.position.y > 260:
		emit_signal('exit_game')
	elif bird.position.y < 16:
		bird.position.y = 16

func _on_Bird_area_entered(area):
	emit_signal('exit_game')