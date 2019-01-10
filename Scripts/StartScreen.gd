extends Control

func _on_Start_focus_entered():
	$SelectionSound.play()

func _on_High_Scores_focus_entered():
	$SelectionSound.play()

func _on_Start_pressed():
	$ConfirmSound.play()
	get_parent().get_parent().change_state('play')

func _on_High_Scores_pressed():
	$ConfirmSound.play()
