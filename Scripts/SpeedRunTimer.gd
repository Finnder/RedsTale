extends Control

const DEFAULT_INCREMENT_RATE = 0.1
export var timerIncrementRate : float = DEFAULT_INCREMENT_RATE

func _ready():
	
	if GameManager.SpeedRunTimerEnabled:
		show()
	else:
		hide()
		
func StartSpeedRunTimer():
	if GameManager.SpeedRunTimerEnabled and GameManager.CurrentLevel == 0:
		print("Speed Run Timer Started")
		show()
		$speedrun_timer.wait_time = timerIncrementRate
		$speedrun_timer.start()
		
	else:
		hide()

func _on_speedrun_timer_timeout():
	GameManager.SpeedRunTimerCurrent += timerIncrementRate
	$SpeedRunPanel/Timer.text = str(GameManager.SpeedRunTimerCurrent)
	
