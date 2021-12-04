extends Node2D

func _on_Button_mouse_entered():
	sounds.button.play()


func _on_newGameButton_pressed():
	global.start_game()


func _on_continueButton_pressed():
	global.load_game()
