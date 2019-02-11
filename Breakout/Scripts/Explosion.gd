extends Particles2D

func explode(brick_pos, brick_colour, brick_tier):
	position = brick_pos
	var colour = CONSTANTS.COLOURS[brick_colour - 1]
	process_material.color_ramp.gradient.colors[0] = Color(colour[0], colour[1], colour[2], (55.0 + (brick_tier + 1))/255.0) 
	restart()