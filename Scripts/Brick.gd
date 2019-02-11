extends Area2D

var tier = null
var colour = null

func init(brick_pos, brick_colour, brick_tier):
	position = brick_pos
	tier = brick_tier
	colour = brick_colour
	reduce_tier(0)

func reduce_tier(amount):
	tier -= amount
	if (tier < 0):
		tier = 0
		colour -= amount
	var index = (colour - 1) * 4 + tier
	$brick.region_rect = Rect2(32 * (index % 6), 16 * (index / 6), 32, 16)