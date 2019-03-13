extends TileMap

func _ready():
	randomize()
	var tile_id = randi() % 108
	for x in range(18):
		set_cell(x, 5, tile_id)
