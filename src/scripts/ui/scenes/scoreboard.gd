extends Node2D


func _ready():
	global.load_scoreboard()
	
	$ScoreboardMain/StagesScoreboard/Wins/Tester.text = str(global.wins[2])
	$ScoreboardMain/StagesScoreboard/Wins/Developer.text = str(global.wins[1])
	$ScoreboardMain/StagesScoreboard/Wins/ProjectManager.text = str(global.wins[0])
	
	$ScoreboardMain/StagesScoreboard/Losses/Tester.text = str(global.losses[2])
	$ScoreboardMain/StagesScoreboard/Losses/Developer.text = str(global.losses[1])
	$ScoreboardMain/StagesScoreboard/Losses/ProjectManager.text = str(global.losses[0])
	
	$ScoreboardMain/StagesScoreboard/BestTime/Tester.text = "%d:%02d" % [global.best_times[2], (global.best_times[2] - floor(global.best_times[2]))*100]
	$ScoreboardMain/StagesScoreboard/BestTime/Developer.text = "%d:%02d" % [global.best_times[1], (global.best_times[1] - floor(global.best_times[1]))*100]
	$ScoreboardMain/StagesScoreboard/BestTime/ProjectManager.text = "%d:%02d" % [global.best_times[0], (global.best_times[0] - floor(global.best_times[0]))*100]
