extends Sprite

var tier = null

func init(tier):
	self.tier = tier
	var x = 0
	var y = 0
	if tier > 53:
		tier -= 53
		x += 5

	y = tier % 9
	x += tier % 6

	set_region_rect(Rect2(x * 32, y * 32, 32, 32))

func get_position():
	return position / 32