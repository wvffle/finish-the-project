extends Node

const DEFAULT_STAGE_TIME = 30
const SAVE_FILE = "save.json"
const _STAGE_ORDER = [
	'StageProjectManager',
	'StageTester',
	'StageDeveloper'
]

signal stage_lost(remaining_time, score)
signal stage_won(remaining_time, score)
signal game_lost(score)


var lives = 3
var stage_time = 0
var level = 0
var score = 0
var paused = false

var _stage = 0



func start_game():
	lives = 3
	level = 1
	score = 0
	_stage = 0
	print('new game')
	# TODO: Display remaining lives screen for 3 seconds
	start_stage(_STAGE_ORDER[_stage])
	
func start_stage(stage):
	stage_time = DEFAULT_STAGE_TIME - (DEFAULT_STAGE_TIME * pow(level, 2) / 100)
	save()
	print('lives: ' + str(lives))
	print('level: ' + str(level))
	print('stage: ' + str(_stage + 1))
	print('time: ' + str(stage_time))
	print('score: ' + str(score))
	get_tree().change_scene("res://src/scenes/stages/" + stage + ".tscn")
	
func stage_won(remaining_time):
	var delta = floor(100 + 100 * remaining_time / max(stage_time, 0.001))
	score += delta
	emit_signal('stage_won', remaining_time, score)
	print('stage won')
	_next_stage()
	
func stage_lost(remaining_time):
	lives -= 1
	
	if lives == 0:
		return game_lost()
		
	# TODO: Display remaining lives screen for 3 seconds
	emit_signal('stage_lost', remaining_time, 0)
	print('stage lost')
	_next_stage()
	
func _next_stage():
	_stage += 1
	if _stage >= 3:
		level += 1
		_stage = 0
	start_stage(_STAGE_ORDER[_stage])
		
func game_lost():
	# TODO: Display score screen
	# TODO: Save score
	emit_signal('game_lost', score)
	print('game lost')
	print('score: ' + str(score))
	
	# TODO: Remove
	get_tree().change_scene("res://src/scenes/Game.tscn")
	
	
func save():
	var save_dict = {
		"level" : level,
		"stage": _stage,
		"lives": lives,
		"score": score
	}
	
	save_file(SAVE_FILE, save_dict)
	
func save_file(filename, data):
	var file = File.new()
	file.open(filename,File.WRITE)
	file.store_line(to_json(data))
	file.close()
	
func file_exists(filename):
	var file = File.new()
	return file.file_exists(filename)
