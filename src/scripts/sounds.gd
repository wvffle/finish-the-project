extends Node2D


var mainTheme
var button
var soundsCanPlay = true

func _ready():
	var node = global.get_node("/root/BackgroundSounds")
	mainTheme = node.find_node("MainTheme")
	button = node.find_node("ButtonSound")

func button_hover():
	if sounds.soundsCanPlay:
		sounds.button.play()
