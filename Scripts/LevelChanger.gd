extends Node2D

enum LevelChangeType {
	next, # Goes to next level
	prev, # goes to prev level
	reset
}

var startedTheGame : bool = false

export var levelType = LevelChangeType.next
var scenetochangeto 

export var incrementLevel = 1

func goToNextLevel() -> void:
	
	GameManager.CurrentLevel += incrementLevel
	
	# Check Zone 
	if GameManager.CurrentLevel < 10:
		scenetochangeto = "res://Scenes/Dungeon/Dungeon" + str(GameManager.CurrentLevel) + ".tscn"
	
	elif GameManager.CurrentLevel >= 18:
		
		# Play music when loading hell
		if GameManager.CurrentLevel == 18:
			MusicController.cur_music = MusicController.Music.HELL_MUSIC
			MusicController.PlayBackgroundMusic()
			
		scenetochangeto = "res://Scenes/Hell/Hell" + str(GameManager.CurrentLevel) + ".tscn"
		
		# Update new speed run score
		if GameManager.SpeedRunTimerCurrent < GameManager.SpeedRunTimerBest and GameManager.CurrentLevel == 25 and GameManager.SpeedRunTimerEnabled:
			GameManager.SpeedRunTimerBest = GameManager.SpeedRunTimerCurrent
			print("New Best: " + str(GameManager.SpeedRunTimerBest))
				

	elif GameManager.CurrentLevel >= 10:
		if GameManager.CurrentLevel == 10:
			MusicController.cur_music = MusicController.Music.JUNGLE_MUSIC
			MusicController.PlayBackgroundMusic()
		
		scenetochangeto = "res://Scenes/Forest/Forest" + str(GameManager.CurrentLevel) + ".tscn"
	
	
	SaveManager.SaveGame()
	get_tree().change_scene(scenetochangeto)

func resetLevel() -> void:
	
	if GameManager.CurrentLevel < 10:
		scenetochangeto = "res://Scenes/Dungeon/Dungeon" + str(GameManager.CurrentLevel) + ".tscn"
	
	elif GameManager.CurrentLevel >= 18:
		scenetochangeto = "res://Scenes/Hell/Hell" + str(GameManager.CurrentLevel) + ".tscn"
		
		if GameManager.CurrentLevel == 25:
			print("Loaded last level")
	
	elif GameManager.CurrentLevel >= 10:
		scenetochangeto = "res://Scenes/Forest/Forest" + str(GameManager.CurrentLevel) + ".tscn"
		
		
	get_tree().change_scene(scenetochangeto)

func _on_Area2D_area_entered(area):
	if levelType == LevelChangeType.next:
		goToNextLevel()
	elif levelType == LevelChangeType.reset:
		resetLevel()
