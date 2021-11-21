extends Node2D

func _on_Button_mouse_entered():
	global.get_node("/root/BackgroundMusic").playButtonSound()


func _on_newGameButton_pressed():
	global.start_game()

