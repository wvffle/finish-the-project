extends Node

const STAGE_TIME = 30

signal stage_lost(remaining_time)
signal stage_won(remaining_time)
signal game_lost(score)


var lives = 3
var remaining_time = 0
var level = 0

var _stage = 0
var _stage_order = [
	'StageProjectManager',
	'StageTester',
	'StageDeveloper'
]

func start_game():
	lives = 3
	level = 1
	print('new game')
	# TODO: Display remaining lives screen for 3 seconds
	_stage = 0
	start_stage(_stage_order[0])
	
func start_stage(stage):
	print('lives: ' + str(lives))
	print('level: ' + str(level))
	print('stage: ' + str(_stage + 1))
	get_tree().change_scene("res://src/scenes/stages/" + stage + ".tscn")
	remaining_time = STAGE_TIME / level
	
func stage_won():
	emit_signal('stage_won', 0)
	print('stage won')
	_next_stage()
	
func stage_lost():
	lives -= 1
	
	if lives == 0:
		return game_lost()
		
	# TODO: Display remaining lives screen for 3 seconds
	emit_signal('stage_lost', 0)
	print('stage lost')
	_next_stage()
	
func _next_stage():
	_stage += 1
	if _stage >= 3:
		level += 1
		_stage = 0
	start_stage(_stage_order[_stage])
		
func game_lost():
	# TODO: Display score screen
	# TODO: Save score
	emit_signal('game_lost', 0)
	print('game lost')
	
	# TODO: Remove
	get_tree().change_scene("res://src/scenes/Game.tscn")
