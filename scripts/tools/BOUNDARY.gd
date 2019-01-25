tool
extends Node2D

var boundary = Rect2(0, 0, 384, 216)

func _draw():
	if Engine.editor_hint:
		draw_rect(boundary, Color('#ffffff'), false)