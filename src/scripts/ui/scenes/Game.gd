extends Node2D

func _on_Button_mouse_entered():
	$ButtonSound.play()


func _on_newGameButton_pressed():
	global.start_game()
