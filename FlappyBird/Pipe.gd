extends Node2D

signal scored

var Bird = preload("res://Bird.tscn")
var scored = false

func init(pos, gap):
	position = pos
	$UpperPipe.position.y -= gap + randf() * gap * (0.75)

func _process(delta):
	position.x -= 60 * delta

	if !scored and position.x < 256 - 14:
		emit_signal('scored')
		scored = true
		$Score.play()
	elif (position.x < -32):
		queue_free()
