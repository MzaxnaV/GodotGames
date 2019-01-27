extends ViewportContainer

func _ready():
	$GameViewport.set_size_override_stretch(true)
	$GameViewport.set_size_override(true, CONFIG.VIEWPORT_SIZE)