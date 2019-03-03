extends TileMap

func _ready():
	randomize()
	#HACK, use this-> VisualServer.set_default_clear_color(Color(randf(), randf(), randf()))
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(randf(), randf(), randf()))