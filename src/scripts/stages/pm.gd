extends Node2D


func _ready ():
	print(randi())
	var a = (randi() % 7)
	var b = (7 - a)

	var x1 = $__track__.rect_global_position.x
	var x2 = $__track__.rect_global_position.x + $__track__.rect_size.x
	var w = $__track__.rect_size.x
	
	var o = w/2
	var l = 71
	var c = floor(l/2)
	var h = b - a
	var g = h + c
	var f = c - h
	var dL = o/g
	var dP = o/f
	var tick = {
		[-c]: 0,
		[c]: w,
		[h]: o
	}
	
	for i in range(1, g):
		tick[-c + i] = i * dL
		
	for i in range(1, f):
		tick[c - f + i] = i * dP + w/2

	print(range(1, g))
	print(range(1, f))
	print(tick)
