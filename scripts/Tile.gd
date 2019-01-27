extends Sprite

var index = null

func init(index):
	self.index = index
	var x = 0
	var y = 0
	if index > 53:
		index -= 53
		x += 5

	y = index % 9
	x += index % 6

	set_region_rect(Rect2(x * 32, y * 32, 32, 32))