extends RichTextLabel

var colours = [
	"#d95763",
	"#5fcde4",
	"#fbf236",
	"#76428a",
	"#99e550",
	"#df7126"
]

var i = 0

func _ready():
	set_use_bbcode(true)

func _on_Timer_timeout():
	set_bbcode("[color=" + colours[(i + 5) % 6] + "]M[/color][color=" + colours[(i + 4) % 6] + "]A[/color][color=" + colours[(i + 3) % 6] + "]T[/color][color=" + colours[(i + 2) % 6] + "]C[/color][color=" + colours[(i + 1) % 6] + "]H[/color] [color=" + colours[i % 6] + "]3[/color]")
	i += 1
