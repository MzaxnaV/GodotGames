extends Node

func _ready():
	randomize()
	$Dirt.generate_ground()
	$Flora.generate_flora()
	#HACK, use this-> VisualServer.set_default_clear_color(Color(randf(), randf(), randf()))
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color(randf(), randf(), randf()))

func _input(event):
	if event.is_action_pressed("debug_r"):
		$Dirt.generate_ground()
		$Flora.generate_flora()