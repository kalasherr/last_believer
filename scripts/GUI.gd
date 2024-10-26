extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Timers/LevelTimer".start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_controller()

func timer_controller():
	var timer_text = ""
	var level_timer = $"../Timers/LevelTimer"
	if level_timer.time_left/60 < 10:
		timer_text = "0" + str(int(level_timer.time_left/60)) + ":"
	else:
		timer_text = str(int(level_timer.time_left/60)) + ":"
	if int(level_timer.time_left)%60 < 10:
		timer_text += "0" + str(int(level_timer.time_left)%60)
	else:
		timer_text += str(int(level_timer.time_left)%60)
	$TimerLabel.text = timer_text
	
