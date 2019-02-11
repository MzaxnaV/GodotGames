extends Sprite

var colour = null
var variation = null

func init(pos, col, v):
	position = pos
	colour = col
	variation = v 
	var x = 0
	var y = 0
	if colour > 9:
		colour -= 9
		x += 5

	y = (colour - 1)
	x += (variation - 1)

	set_region_rect(Rect2(x * 32, y * 32, 32, 32))

func get_position():
	return position / 32