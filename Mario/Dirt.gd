extends TileMap

func _ready():
	randomize()
	#HACK, use this-> VisualServer.set_default_clear_color(Color(randf(), randf(), randf()))
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(randf(), randf(), randf()))
	generate_ground()

func generate_ground():
	var tile_id = randi() % 60
	for x in range(18):
		for y in range(4):
			set_cell(x, 5 + y, tile_id)