extends ItemList

var InfoContent = ["Level: 1", "Score: 999999", "Goal: 999999", "Timer: 999"]

func _ready():
	for info in InfoContent:
		add_item(info, null, false)