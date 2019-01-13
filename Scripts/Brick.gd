extends Sprite

func init(brick_tex_pos, x, y):
	set_region_rect(Rect2(brick_tex_pos.x, brick_tex_pos.y, 32, 16))
	position.x = x
	position.y = y