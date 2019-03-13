tool
extends Button

export(Texture) var tileset_texture
export(Vector2) var offset
export(Vector2) var skip_cells
export(Vector2) var tile_size
export(Vector2) var boundary

func _on_tileset_builder_pressed():
	generate_tileset()

func generate_tileset():
	var tile = null
	var scene_root = get_tree().get_edited_scene_root()
	var counter = 0
	for y in range(boundary.y):
		for x in range(boundary.x):
			tile = Sprite.new()
			tile.name = str(counter)
			tile.texture = tileset_texture
			tile.region_enabled = true
			tile.region_rect = Rect2((offset.x + (skip_cells.x + 1) * x) * 16, (offset.y + (skip_cells.y + 1) * y) * 16, tile_size.x, tile_size.y)
			tile.position = Vector2(x * 17, y * 17)
			scene_root.add_child(tile)
			tile.set_owner(scene_root)
			counter += 1