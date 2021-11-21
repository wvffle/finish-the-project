extends Node2D

func playMusic():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	
func playButtonSound():
	$ButtonSound.play()
	

