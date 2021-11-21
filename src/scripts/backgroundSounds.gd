extends Node2D
	
#func _on_Button_mouse_entered():
#	$ButtonSound.play()

func play():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

