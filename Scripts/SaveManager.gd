extends Node

const SAVE_DIR = "user://saves/"


const saveFileName = "save"
const nodeleteFileName = "NODELETE"

var save_path = "user://saves/" + saveFileName + ".dat"
var nodelete_savepath = "user://saves/" + nodeleteFileName + ".dat"

var master_bus = AudioServer.get_bus_index("Master")

# SAVED DATA
var data
var NoDeleteSave

func SaveGame():
	data = {
		"playerResources": {
			"gold": ResourceManager.coins,
			"collectables": {
				"weepingWomen": ResourceManager.hasWeepingWomen,
				"snake": ResourceManager.hasSnake,
				"scripture":ResourceManager.hasScripture,
				"hood": ResourceManager.hasHood,
				"sunset": ResourceManager.hasSunset,
				"flower": ResourceManager.hasFlower,
				"jenee": ResourceManager.hasJenee,
				"xylaphone": ResourceManager.hasXylaphone
			}
		},
		"leveldata": {
			"currentLevel": GameManager.CurrentLevel,
		}
	}
	
	# Stuff that will be saved even after user presses clear save
	NoDeleteSave = {
		"speedrundata": {
			"best": GameManager.SpeedRunTimerBest
		},
		"settings": {
			"MasterVolume": AudioServer.get_bus_volume_db(master_bus),
			"MusicVolume": MusicController.BGMusic.volume_db
		},
		#"FirstPlaythrough": GameManager.FirstPlaythrough
	}

	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):		
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		print("Loaded Prev Data")
	
	var nodeletefile = File.new()
	error = nodeletefile.open(nodelete_savepath, File.WRITE)
	if error == OK:
		nodeletefile.store_var(NoDeleteSave)
		nodeletefile.close()
		
func LoadGame():
	
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error != OK:
			if error == 7: print("File Not Found")
			else: print(error)
		else:
			data = file.get_var()
			
			# SET DATA
			GameManager.CurrentLevel = data.get("leveldata").get("currentLevel")
			
			var collectables = data.get("playerResources").get("collectables")
			
			ResourceManager.hasWeepingWomen = collectables.get("weepingWomen")
			ResourceManager.hasFlower = collectables.get("flower")
			ResourceManager.hasHood = collectables.get("hood")
			ResourceManager.hasJenee = collectables.get("jenee")
			ResourceManager.hasScripture = collectables.get("scripture")
			ResourceManager.hasSnake = collectables.get("snake")
			ResourceManager.hasSunset = collectables.get("sunset")
			ResourceManager.hasXylaphone = collectables.get("xylaphone")
			
			file.close()
	
	var nodeleteFile = File.new()
	if nodeleteFile.file_exists(nodelete_savepath):
		var err = nodeleteFile.open(nodelete_savepath, File.READ)
		if err != OK:
			if err == 7: print("No Delete File not found")
			else: print(err)
		else:
			NoDeleteSave = nodeleteFile.get_var()
			
			# SET DATA
			GameManager.SpeedRunTimerBest = NoDeleteSave.get("speedrundata").get("best")
			
			print("Loaded: Speed Run Best -> " + str(GameManager.SpeedRunTimerBest))
			
			AudioServer.set_bus_volume_db(master_bus, NoDeleteSave.get("settings").get("MasterVolume"))
			MusicController.BGMusic.volume_db = NoDeleteSave.get("settings").get("MusicVolume")
			
			nodeleteFile.close()

		
func DeleteGame():
	var dir = Directory.new()
	if dir.dir_exists(SAVE_DIR):
		dir.remove(save_path)
		print("deleted save level file")
		
		GameManager.CurrentLevel = 0
		GameManager.SpeedRunTimerCurrent = 0
		
		ResourceManager.hasWeepingWomen = false
		ResourceManager.hasFlower = false
		ResourceManager.hasHood = false
		ResourceManager.hasJenee = false
		ResourceManager.hasScripture = false
		ResourceManager.hasSnake = false
		ResourceManager.hasSunset = false
		ResourceManager.hasXylaphone = false
		
		ResourceManager.collectablesCollected = 0
		
	else:
		print("Tried deleting a save file that does not exist")
		
		
		
	
# DEBUG
func _on_SaveGame_pressed():
	SaveGame()

func _on_LoadGame_pressed():
	LoadGame()
