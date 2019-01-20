extends "res://Scripts/states/BaseState.gd"

var Level = preload("res://Scenes/Level.tscn")
var Brick = preload("res://Scenes/Brick.tscn")

func enter(params):
	$StartScreen.show()
	$StartScreen.get_child(1).get_child(0).grab_focus()

func exit():
	$StartScreen.hide()
	var level = Level.instance()
	var paddle_skin = 1
	level.populate(generate_bricks(32), paddle_skin)
	return level

func generate_bricks(level):
	var bricks = []

	var colour = 1
	var tier = 0

	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7
	if (num_cols % 2 == 0):
		num_cols += 1

	var highest_tier = int(min(3, level / 5))
	var highest_colour = int(min(3, level % 5 + 3))

	var brick = null
	for y in range(1, num_rows+1):
		var skip_pattern = (randi() % 2 == 0)
		var alternate_pattern = (randi() % 2 == 0)
		
		var alternate_colour1 = 1 + randi() % highest_colour
		var alternate_colour2 = 1 + randi() % highest_colour
		var alternate_tier1 = randi() % (highest_tier + 1)
		var alternate_tier2 = randi() % (highest_tier + 1)

		var skip_flag = (randi() % 2 == 0)
		var alternate_flag = (randi() % 2 == 0)

		var solid_colour = 1 + randi() % highest_colour
		var solid_tier = randi() % (highest_tier + 1)

		for x in range(1, num_cols+1):

			if skip_pattern and skip_flag:
				skip_flag = !skip_flag
				continue
			else:
				skip_flag = !skip_flag

			if alternate_pattern and alternate_flag:
				colour = alternate_colour1
				tier = alternate_tier1
				alternate_flag = !alternate_flag
			else:
				colour = alternate_colour2
				tier = alternate_tier2
				alternate_flag = !alternate_flag
			
			if !alternate_pattern:
				colour = solid_colour
				tier = solid_tier

			brick = Brick.instance()
			brick.init(
				Vector2((x-1) * 32 + 8 + (13 - num_cols) * 16 + 16, y * 16 + 8),
				colour,
				tier
			) 
			bricks.append(brick)

	return bricks