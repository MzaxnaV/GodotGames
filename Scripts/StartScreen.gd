extends Control

func _ready():
	$Menu/Start.grab_focus()

func _on_Start_focus_entered():
	$SelectionSound.play()

func _on_High_Scores_focus_entered():
	$SelectionSound.play()
