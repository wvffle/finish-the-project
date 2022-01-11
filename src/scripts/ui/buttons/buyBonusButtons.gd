extends Control


func disable_setting():
	for bonusIndex in range(0, global.BONUS_NAME.size()):
		get_node("__score__label").set_text('Score: ' + str(global.score))
		get_node('__buy_' + global.BONUS_NAME[bonusIndex] + '_button__').set_disabled(global.score < global.BONUS_COST[bonusIndex])
		get_node('__stock_' + global.BONUS_NAME[bonusIndex] + '_counter__').set_text(str(global.BONUS_NAME[bonusIndex]) + ' stock: ' + str(global.bonus_stock[bonusIndex]))
	
	
func _ready():
	for bonusIndex in range(0, global.BONUS_NAME.size()):
		get_node('__buy_' + global.BONUS_NAME[bonusIndex] + '_button__').set_text('buy ' + str(global.BONUS_NAME[bonusIndex]) + ' ' + str(global.BONUS_COST[bonusIndex]))
	disable_setting()
	
	
func _on_Button_pressed():
	for bonusIndex in range(0, global.BONUS_NAME.size()):
		if get_node('__buy_' + global.BONUS_NAME[bonusIndex] + '_button__').is_pressed():
			global.score -= global.BONUS_COST[bonusIndex]
			global.bonus_stock[bonusIndex] += 1
			disable_setting()

	global.save_state()


func _on_Button_mouse_entered():
	sounds.button_hover()
