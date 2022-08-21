extends Control

var savedLevel : String = ""
var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	
	MusicController.cur_music = MusicController.Music.MENU_MUSIC
	MusicController.PlayBackgroundMusic()
	
	SaveManager.LoadGame()
	
	$"SettingsMenu/FullScreen?".pressed = OS.window_fullscreen

	if GameManager.SpeedRunTimerBest < GameManager.BEST_DEFAULT and GameManager.SpeedRunTimerBest > 0:
		$bestTimeLabel.text = "Best Time: " + str(GameManager.SpeedRunTimerBest)
	else:
		$bestTimeLabel.text = ""
		
	# Speed Run Timer Menu 
	$"SettingsMenu/SpeedRunTimer?".pressed = GameManager.SpeedRunTimerEnabled
	$"SettingsMenu/SpeedRunTimer?".modulate.a = 0.2
	$"SettingsMenu/SpeedRunTimer?".disabled = true
	$"SettingsMenu/SpeedRunTimer?/Warning".visible = true
	
	# IF Player Save Data is not new
	if GameManager.CurrentLevel != 0:
		$Play/RichTextLabel.text = "Continue Your Journey"
		$SettingsMenu/GameData.show()
	else:
		$"SettingsMenu/SpeedRunTimer?".modulate.a = 1
		$"SettingsMenu/SpeedRunTimer?".disabled = false
		
	# Loading Saved Settings
	$SettingsMenu/MasterVolume/VolumeSlider.value = AudioServer.get_bus_volume_db(master_bus)
	$SettingsMenu/MusicVolume/MusicVolSlider.value = MusicController.BGMusic.volume_db
	

func StartGame():
	
	# CAVE AREA
	if GameManager.CurrentLevel < 10:
		MusicController.cur_music = MusicController.Music.CAVE_MUSIC
		savedLevel = "res://Scenes/Dungeon/Dungeon" + str(GameManager.CurrentLevel) + ".tscn"
		
	# HELL AREA
	elif GameManager.CurrentLevel >= 18:
		MusicController.cur_music = MusicController.Music.HELL_MUSIC
		savedLevel = "res://Scenes/Hell/Hell" + str(GameManager.CurrentLevel) + ".tscn"
		
	# JUNGLE AREA
	elif GameManager.CurrentLevel >= 10:
		MusicController.cur_music = MusicController.Music.JUNGLE_MUSIC
		savedLevel = "res://Scenes/Forest/Forest" + str(GameManager.CurrentLevel) + ".tscn"
	
	MusicController.PlayBackgroundMusic()
	get_tree().change_scene(savedLevel)
	
	

func _on_Play_pressed():
	StartGame()
	MusicController.PlayButtonPress()

func _on_Settings_pressed():
	$MenuCamera/AnimationPlayer.play("SlideR")
	MusicController.PlayButtonPress()


func _on_Exit_Settings_pressed():
	$MenuCamera/AnimationPlayer.play("SlideL")
	MusicController.PlayButtonPress()


func _on_FullScreen_toggled(button_pressed):
	MusicController.PlayButtonPress()
	if button_pressed == true:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false


func _on_ClearSave_pressed():
	MusicController.PlayButtonPress()
	
	# Delete the saved data
	SaveManager.DeleteGame()
	
	# UI Elements to change
	$SettingsMenu/GameData.hide()
	$Play/RichTextLabel.text = "Begin Your Journey"
	$"SettingsMenu/SpeedRunTimer?".disabled = false
	$"SettingsMenu/SpeedRunTimer?".modulate.a = 1
	$"SettingsMenu/SpeedRunTimer?/Warning".visible = false
	

	
	# Variables To Reset
	GameManager.CurrentLevel = 0
	
	# Save the new data
	SaveManager.SaveGame()


# MASTER VOLUME SLIDER
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value <= -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_Exit_pressed():
	MusicController.PlayButtonPress()
	get_tree().quit()


func _on_MusicVolSlider_value_changed(value):
	MusicController.BGMusic.volume_db = value;
	

func _on_SpeedRunTimer_toggled(button_pressed):
	MusicController.PlayButtonPress()
	print("Speed Run Timer Now: " + str(button_pressed))
	GameManager.SpeedRunTimerEnabled = button_pressed

# COLLECTABLES
func _on_Collectables_pressed():
	$MenuCamera/AnimationPlayer.play("SlideToCollectables")
	OnReadyCollectables()
	MusicController.PlayButtonPress()


func _on_BackToMenu_pressed():
	$MenuCamera/AnimationPlayer.play("SlideToMenuFromCollectables")
	MusicController.PlayButtonPress()
	
func OnReadyCollectables():
	$CollectablesMenu/WeepingWomen/Collected.visible = ResourceManager.hasWeepingWomen
	$CollectablesMenu/Snake/Collected.visible = ResourceManager.hasSnake
	$CollectablesMenu/Scripture/Collected.visible = ResourceManager.hasScripture
	$CollectablesMenu/Hood/Collected.visible = ResourceManager.hasHood
	$CollectablesMenu/Sunset/Collected.visible = ResourceManager.hasSunset
	$CollectablesMenu/Flower/Collected.visible = ResourceManager.hasFlower
	$CollectablesMenu/Jenee/Collected.visible = ResourceManager.hasJenee
