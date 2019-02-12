extends CanvasLayer

signal game_over

var leftScore = 0
var rightScore = 0

func reset():
	$LeftScore.text = "0"
	$RightScore.text = "0"
	$Message.hide()


func show_game_over(winner):
	$Message.text = winner + "wins, Press Enter key to play again..."
	$Message.show()

func start_game():
	$Message.text = "Get Ready..."
	yield($Timer, "timeout")
	$Message.hide()


func _on_Ball_update_score(left_score, right_score):
	leftScore += left_score
	rightScore += right_score
	$LeftScore.text = str(leftScore)
	$RightScore.text = str(rightScore)
	if (leftScore >= 5 || rightScore >= 5):
		emit_signal("game_over")
		if leftScore > rightScore:
			show_game_over("Player1")
		else:
			show_game_over("Player2")