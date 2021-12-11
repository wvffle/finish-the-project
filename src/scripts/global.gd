extends Node

const DEFAULT_STAGE_TIME = 30
const SAVE_FILE = "save.json"
const CONFIG_FILE = "config.json"

const _STAGE_ORDER = [
	'StageDeveloper',
	'StageProjectManager',
	'StageTester',
]
const DIFFICULTY_MODIFIERS = [
	1.2,
	1,
	0.8
]
signal stage_lost(remaining_time, score)
signal stage_won(remaining_time, score)

signal game_lost(score)


var lives = 3
var stage_time = 0
var level = 0
var score = 0
var paused = false

var difficulty = 1

var _stage = 0

var _first_start = true

# === DEV START ===
func start_game():
	lives = 3
	level = 1
	score = 0
	_stage = 0
	
	# dev:skip-next-line
	print('new game')
	
	# TODO: Display remaining lives screen for 3 seconds
	
	# dev:blank-next-line
	start_stage(_STAGE_ORDER[_stage])
	# dev:wrong-answer:start_game(_STAGE_ORDER[_stage])
	# dev:wrong-answer:start_stage(_STAGE_ORDER[stage])
# === DEV END ===
	
func start_stage(stage):
	stage_time = (DEFAULT_STAGE_TIME - (DEFAULT_STAGE_TIME * pow(level, 2) / 100)) * DIFFICULTY_MODIFIERS[difficulty]
	save()
	print('lives: ' + str(lives))
	print('level: ' + str(level))
	print('difficulty mode: ' + str(difficulty))
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
	
# === DEV START ===
func stage_lost(remaining_time):
	lives -= 1
	
	if lives == 0:
		# dev:blank-next-line
		return game_lost()
		# dev:wrong-answer:game_lost()
		
	# TODO: Display remaining lives screen for 3 seconds
	emit_signal('stage_lost', remaining_time, 0)
	
	# dev:skip-next-line
	print('stage lost')
	# dev:blank-next-line
	_next_stage()
	# dev:wrong-answer:game_won()
# === DEV END ===
	
# === DEV START ===
func _next_stage():
	_stage += 1
	if _stage >= 3:
		# dev:blank-next-line
		level += 1
		# dev:wrong-answer:lives += 1
		_stage = 0
	start_stage(_STAGE_ORDER[_stage])
# === DEV END ===
		
# === DEV START ===
func game_lost():
	# TODO: Display score screen
	# TODO: Save score
	emit_signal('game_lost', score)
	print('game lost')
	print('score: ' + str(score))

	# TODO: Remove
	# dev:blank-next-line
	get_tree().change_scene("res://src/scenes/Game.tscn")
	# dev:wrong-answer:_back_to_menu()
	# dev:wrong-answer:get_tree().show_root_scene()
# === DEV END ===


func save():
	var save_dict = {
		"level": level,
		"stage": _stage,
		"lives": lives,
		"score": score,
		"difficulty": difficulty,
	}
	
	save_file(SAVE_FILE, save_dict)

func save_config():
	var config_dict = {
		"mainThemeVolume": sounds.mainTheme.get_volume_db(),
		"buttonVolume": sounds.button.get_volume_db(),
		"soundsCanPlay": sounds.mainTheme.is_playing(),
		"difficulty": difficulty,
	}
	
	save_file(CONFIG_FILE, config_dict)

func save_file(filename, data):
	var file = File.new()
	file.open(filename,File.WRITE)
	file.store_line(to_json(data))
	file.close()

func file_exists(filename):
	var file = File.new()
	return file.file_exists(filename)
	
func load_file(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var data = parse_json(file.get_line())
	file.close()
	return data
	
func load_game():
	if not file_exists(SAVE_FILE):
		return
		
	var save = load_file(SAVE_FILE)
	
	level = save.level
	lives = save.lives
	score = save.score
	_stage = save.stage
	difficulty = save.difficulty
	start_stage(_STAGE_ORDER[_stage])
	
func load_config():
	if not file_exists(CONFIG_FILE):
		return
		
	var config = load_file(CONFIG_FILE)
	
	difficulty = config.difficulty
	sounds.mainTheme.set_volume_db(config.mainThemeVolume)
	sounds.button.set_volume_db(config.buttonVolume)
	if config.soundsCanPlay:
		sounds.soundsCanPlay = config.soundsCanPlay
		if _first_start:
			sounds.mainTheme.play()
	_first_start = false
