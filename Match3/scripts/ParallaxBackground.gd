extends ParallaxBackground

const SCROLL_SPEED = 80

func _process(delta):
	scroll_offset.x -= SCROLL_SPEED * delta