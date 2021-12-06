extends Node2D


func _ready():
	set_visible(false)

func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		global.paused = !global.paused
		set_visible(global.paused) 


func _on_continueGameButton_pressed():
	global.paused = false
	set_visible(false) 
