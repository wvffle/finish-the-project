extends Node2D


var progress
var time

func _ready():
	progress = find_node('__progress__')
	time = find_node('__time__')
	get_parent().connect('time_updated', self, '_on_time_updated')
	
func _on_time_updated(timestamp):
	var timeleft = max(0, global.stage_time - timestamp)
	var minutes = floor(timeleft / 60)
	var seconds = floor(timeleft) - minutes * 60
	
	var percent = timestamp / global.stage_time * 100
	
	progress.value = 100 - percent
	time.text = "%d:%02d" % [minutes, seconds]
