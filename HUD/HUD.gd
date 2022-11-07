extends CanvasLayer

signal start_game
	
func update_score(score):
	$ScoreLabel.text = str(score)

func game_over():
	$HeaderLabel.show()
	$StartButton.show()

func _on_StartButton_pressed():
	$HeaderLabel.hide()
	$StartButton.hide()
	$ScoreLabel.text = str(0)
	emit_signal("start_game")
