extends Viewport

var viewportSize = Vector2(512, 288)

func _ready():
	set_size_override(true, viewportSize)
	set_size_override_stretch(true)