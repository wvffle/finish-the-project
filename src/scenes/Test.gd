extends Node2D

func _process(delta):
	
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()


func _on_Button_mouse_entered():
	$ButtonSound.play()
