extends Area2D


func init(brick_tex_pos, x, y):
	$Sprite.set_region_rect(Rect2(brick_tex_pos.x, brick_tex_pos.y, 32, 16))
	position.x = x
	position.y = y

func _on_Brick_area_entered(area):
	get_parent().brick_sound.play()
	queue_free()