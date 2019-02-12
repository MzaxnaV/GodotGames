extends Node

var Pipe = null
var pos = Vector2()
var SCREEN_END = 512 + 32
var lasty = rand_range(60, 288 - 60)

func _ready():
	Pipe = preload("res://Pipe.tscn")
	get_node("PipeSpawnTimer").start()
	randomize()

func _on_PipeSpawnTimer_timeout():
	var newPipe = Pipe.instance()
	pos.x = SCREEN_END
	pos.y = rand_range(60, 288 - 60)
	while(abs(lasty - pos.y) > 80):
		pos.y = rand_range(60, 288 - 60)

	lasty = pos.y
	newPipe.init(pos, 60)
	newPipe.connect("scored", self, "_on_Pipe_scored")
	add_child(newPipe)

func _on_Pipe_scored():
	get_parent().score += 1
	get_parent().get_node("Score").text = "Score: " + str(get_parent().score)