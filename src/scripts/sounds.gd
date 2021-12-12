extends Node2D


var defaultMusicVolume = 0
var defaultButtonSoundVolume = 0
var mainTheme
var button
var soundsCanPlay

func _ready():
	var node = global.get_node("/root/BackgroundSounds")
	mainTheme = node.find_node("MainTheme")
	button = node.find_node("ButtonSound")
	
	mainTheme.stream.set_loop_mode(1)
	mainTheme.stream.set_loop_end(3032064)

func button_hover():
	if sounds.soundsCanPlay:
		sounds.button.play()
