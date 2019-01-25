tool
extends ViewportContainer

const VIEWPORT_SIZE = Vector2(384, 216)

func _ready():
	$GameViewport.set_size_override_stretch(true)
	$GameViewport.set_size_override(true, VIEWPORT_SIZE)

func _draw():
	if Engine.is_editor_hint():
		draw_rect(Rect2(0, 0, VIEWPORT_SIZE.x, VIEWPORT_SIZE.y), Color('#ff0000'), false)