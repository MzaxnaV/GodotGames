extends TileMap

func generate_ground():
	var tile_id = randi() % 60
	for x in range(18):
		for y in range(4):
			set_cell(x, 5 + y, tile_id)