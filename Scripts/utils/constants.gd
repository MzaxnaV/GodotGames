extends Node

const VIRTUAL_WIDTH = 432
const VIRTUAL_HEIGHT = 243

const PADDLE_SPEED = 200

const COLOURS = {
	0 : [99.0/255.0, 155.0/255.0, 255.0/255.0], #blue
	1 : [106.0/255.0, 190.0/255.0, 47.0/255.0], #green
	2 : [217.0/255.0, 87.0/255.0, 99.0/255.0], #red
	3 : [215.0/255.0, 123.0/255.0, 186.0/255.0], # purple
	4 : [251.0/255.0, 242.0/255.0, 54.0/255.0] # gold
}

var highscores = []

func _ready():
	var file = File.new()
	if not file.file_exists("res://breakout.lst"):
		file.open("res://breakout.lst", File.WRITE)
		for i in range(10, 0, -1):
			file.store_line("MAN")
			file.store_line(str(i * 1000))
		file.close()
	else:
		update_highscore()

func update_highscore():
	var file = File.new()
	file.open("res://breakout.lst", File.READ)
	var n = true
	var current_name = null
	var counter = 1

	for i in range(10):
		highscores.append([file.get_line().substr(0, 3), int(file.get_line())])
	
	file.close()
	print(highscores)