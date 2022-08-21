extends Control

var is_paused = false setget set_is_paused
export var debugMode : bool = false

var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	if debugMode:
		$Pause/DebugSetTime.show()
	else:
		$Pause/DebugSetTime.hide()
		
	if OS.window_fullscreen:
		$"InGameSettings/FullScreen?".pressed = true
	else:
		$"InGameSettings/FullScreen?".pressed = false
		
	$InGameSettings/MasterVolumeSlider.value = AudioServer.get_bus_volume_db(master_bus)
	$InGameSettings/MusicVolumeSlider.value = MusicController.BGMusic.volume_db


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused
		print(self.is_paused)
		$Pause/CurrentLevel.text = "Current Level: " + str(GameManager.CurrentLevel)
		$Pause/CurrentTime.visible = GameManager.SpeedRunTimerEnabled
		
		if GameManager.SpeedRunTimerEnabled:
			$Pause/CurrentTime.text = "Current Time: " + str(GameManager.SpeedRunTimerCurrent)


func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	$Pause.visible = true
	$InGameSettings.visible = false
	
	get_parent().get_node("SpeedRunTimer/speedrun_timer").paused = is_paused

func _on_Resume_pressed():
	MusicController.PlayButtonPress()
	self.is_paused = false

func _on_Exit_pressed():
	MusicController.PlayButtonPress()
	SaveManager.SaveGame()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	self.is_paused = false

func _on_DebugSetTime_pressed():
	MusicController.PlayButtonPress()
	GameManager.SpeedRunTimerBest = 10


func _on_Settings_pressed():
	MusicController.PlayButtonPress()
	$Pause.visible = false
	$InGameSettings.visible = true

# SETTINGS
func _on_FullScreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_MasterVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)


func _on_MusicVolumeSlider_value_changed(value):
	MusicController.BGMusic.volume_db = value
