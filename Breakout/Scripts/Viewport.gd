extends Viewport

var viewport_size = Vector2(CONSTANTS.VIRTUAL_WIDTH, CONSTANTS.VIRTUAL_HEIGHT)

func _ready():
	set_size_override(true, viewport_size)
	set_size_override_stretch(true)