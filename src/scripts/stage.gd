extends Node2D


signal time_updated(timestamp)

var time = 0


func _ready():
	global.connect('bonus_use', self, '_use_bonus')


func _process(delta):
	if !global.paused:
		time += delta
		emit_signal("time_updated", time)

	if time > global.stage_time:
		stage_lost()


func stage_won():
	global.stage_won(max(0, global.stage_time - time))


func stage_lost():
	global.stage_lost(max(0, global.stage_time - time))


func _use_bonus(bonus_time):
	time = max(0, time - bonus_time)
	global.save_state()

