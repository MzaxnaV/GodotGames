extends Node

var texture_atlas = null

func _ready():
	texture_atlas = AtlasTexture.new()
	texture_atlas.atlas = load("res://Assets/Graphics/blocks.png")

func get_texture(x, y, texture_width, texture_height):
	texture_atlas.region = Rect2(x, y, texture_width, texture_height)
	return texture_atlas

func get_texture_paddles(size, skin):
	var x = 0
	var y = 32 + 32 * skin

	if size > 3:
		y += 16
	else:
		x = 32 * (size-1) * (size) / 2

	return get_texture(x, y, 32 * size, 16)