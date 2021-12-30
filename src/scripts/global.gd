extends Node


const DEFAULT_STAGE_TIME = 45
const SAVE_FILE = "save.json"
const CONFIG_FILE = "config.json"
const SCOREBOARD_FILE = "scoreboard.json"

const _STAGE_ORDER = [
	'StageProjectManager',
	'StageDeveloper',
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

var wins = [0,0,0]
var losses = [0,0,0]
var best_times = [0,0,0]

var high_score = 0
var highest_level = 0

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
	stage_time = (DEFAULT_STAGE_TIME - (DEFAULT_STAGE_TIME * pow(level, 2) / 1600)) * DIFFICULTY_MODIFIERS[difficulty]
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
	update_stage_scoreboard(true, remaining_time)
	_next_stage()
	
# === DEV START ===
func stage_lost(remaining_time):
	lives -= 1
	update_stage_scoreboard(false, remaining_time)
		
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
	update_main_scoreboard()
	emit_signal('game_lost', score)
	print('game lost')
	print('score: ' + str(score))
	
	# TODO: Remove
	# dev:blank-next-line
	get_tree().change_scene("res://src/scenes/Game.tscn")
	# dev:wrong-answer:_back_to_menu()
	# dev:wrong-answer:get_tree().show_root_scene()
# === DEV END ===

func update_stage_scoreboard(stage_won, remaining_time):
	if stage_won:
		wins[_stage] += 1;
		best_times[_stage] = max(best_times[_stage], stage_time - remaining_time);
	else:
		losses[_stage] += 1;
	save_scoreboard()


func update_main_scoreboard():
	if score > high_score:
		high_score = score
	if level > highest_level:
		highest_level = level 
	save_scoreboard()


func save():
	var save_dict = {
		"level": level,
		"stage": _stage,
		"lives": lives,
		"score": score,
		"difficulty": difficulty,
	}
	
	file.save_file(SAVE_FILE, save_dict)


func save_config():
	var config_dict = {
		"mainThemeVolume": sounds.mainTheme.get_volume_db(),
		"buttonVolume": sounds.button.get_volume_db(),
		"soundsCanPlay": sounds.mainTheme.is_playing(),
		"difficulty": difficulty,
	}

	file.save_file(CONFIG_FILE, config_dict)
	
	
func save_scoreboard():
	var scoreboard_dict = {
		"high_score": high_score,
		"highest_level": highest_level,
		"wins": wins,
		"losses": losses,
		"best_times": best_times,
	}
	
	file.save_file(SCOREBOARD_FILE, scoreboard_dict)

	
func load_game():
	if not file.file_exists(SAVE_FILE):
		return
		
	var save = file.load_file(SAVE_FILE)
	
	level = save.level
	lives = save.lives
	score = save.score
	_stage = save.stage
	difficulty = save.difficulty
	start_stage(_STAGE_ORDER[_stage])
	
	
func load_config():
	if not file.file_exists(CONFIG_FILE):
		if !sounds.soundsCanPlay:
			sounds.soundsCanPlay = true
			sounds.mainTheme.play()
		return
		
	var config = file.load_file(CONFIG_FILE)
	
	difficulty = config.difficulty
	sounds.mainTheme.set_volume_db(config.mainThemeVolume)
	sounds.button.set_volume_db(config.buttonVolume)
	if config.soundsCanPlay:
		sounds.soundsCanPlay = config.soundsCanPlay
		if _first_start:
			sounds.mainTheme.play()
	_first_start = false


func load_scoreboard():
	if not file.file_exists(SCOREBOARD_FILE):
		wins = [0,0,0]
		losses = [0,0,0]
		best_times = [0,0,0]

		high_score = 0
		highest_level = 0
		return
		
	var scoreboard = file.load_file(SCOREBOARD_FILE)
	
	high_score = scoreboard.high_score
	highest_level = scoreboard.highest_level
	wins = scoreboard.wins
	losses = scoreboard.losses
	best_times = scoreboard.best_times
