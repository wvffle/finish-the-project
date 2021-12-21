extends Node2D


func _ready():
	global.load_config()
	
	
func _on_Button_mouse_entered():
	sounds.button_hover()


func _on_newGameButton_pressed():
	randomize()
	global.start_game()


func _on_continueButton_pressed():
	global.load_game()
