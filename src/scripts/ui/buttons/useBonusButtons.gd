extends Node2D


func disable_setting(bonusIndex):
	get_node('__use_' + global.BONUS_NAME[bonusIndex] + '_button__').set_disabled(global.bonus_stock[bonusIndex] == 0)
	get_node('__use_' + global.BONUS_NAME[bonusIndex] + '_button__').set_text('use ' + str(global.BONUS_NAME[bonusIndex]) + ': ' + str(global.bonus_stock[bonusIndex]))
	
	
func _ready():
	for bonusIndex in range(0, global.BONUS_NAME.size()):
		disable_setting(bonusIndex)
	
	
func _on_Button_pressed():
	for bonusIndex in range(0, global.BONUS_NAME.size()):
		if get_node('__use_' + global.BONUS_NAME[bonusIndex] + '_button__').is_pressed():
			global.bonus_stock[bonusIndex] -= 1
			global.emit_signal('bonus_use', global.BONUS_TIME[bonusIndex])
			disable_setting(bonusIndex)


func _on_Button_mouse_entered():
	sounds.button_hover()
