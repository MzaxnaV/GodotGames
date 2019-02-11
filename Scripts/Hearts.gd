extends Node

const full = Rect2(0, 0, 10, 9)
const empty = Rect2(10, 0, 10, 9)

func change_heart(health):
	match health:
		1:
			$Heart1.set_region_rect(full)
			$Heart2.set_region_rect(empty)
			$Heart3.set_region_rect(empty)
		2:
			$Heart1.set_region_rect(full)
			$Heart2.set_region_rect(full)
			$Heart3.set_region_rect(empty)
		3:
			$Heart1.set_region_rect(full)
			$Heart2.set_region_rect(full)
			$Heart3.set_region_rect(full)