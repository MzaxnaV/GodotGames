extends Node

func _on_HUD_game_over():
	if Input.is_key_pressed(KEY_ENTER):
		$HUD.start_game()

func _ready():
	$HUD.reset()
	$HUD.start_game()