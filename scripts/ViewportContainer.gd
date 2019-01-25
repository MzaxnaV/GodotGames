tool #HOTFIX so that editor shows the game as it should be
extends ViewportContainer

const CONFIG = preload('res://scripts/config.gd')

func _ready():
	$GameViewport.set_size_override_stretch(true)
	$GameViewport.set_size_override(true, CONFIG.VIEWPORT_SIZE)