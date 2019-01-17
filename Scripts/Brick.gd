extends Area2D

var skin = null

func init(brick_pos, brick_region, brick_skin):
	position = brick_pos
	$brick.region_rect = brick_region
	skin = brick_skin