extends Node

signal stage_lost
signal game_lost(score)

var lives = 3

func start_game():
	lives = 3
	# TODO: Display remaining lives screen for 3 seconds
	start_stage()
	
func start_stage():
	pass
	
func stage_lost():
	lives -= 1
	
	if lives == 0:
		return game_lost()
		
	# TODO: Display remaining lives screen for 3 seconds
	emit_signal('stage_lost')
		
func game_lost():
	# TODO: Display score screen
	# TODO: Save score
	emit_signal('game_lost', 0)
