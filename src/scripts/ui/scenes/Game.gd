extends Node2D

func _process(delta):
	global.get_node("/root/BackgroundMusic").play()	

func _on_Button_mouse_entered():
	$ButtonSound.play()


func _on_newGameButton_pressed():
	global.start_game()
