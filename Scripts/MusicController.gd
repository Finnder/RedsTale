extends Node

var cave_music
var jungle_music 
var hell_music
var menu_music

var bgmusicplaying : bool = false
var musicState : int = 1

var BGMusic : AudioStreamPlayer

enum Music {
	CAVE_MUSIC,
	JUNGLE_MUSIC,
	HELL_MUSIC,
	MENU_MUSIC
}

var cur_music = Music.CAVE_MUSIC

func _ready():
	
	cave_music = load("res://Assets/Sounds/Areas/CaveBG.mp3")
	jungle_music = load("res://Assets/Sounds/Areas/JungleBG.mp3")
	hell_music = load("res://Assets/Sounds/Areas/HellBG.mp3")
	menu_music = load("res://Assets/Sounds/MenuMusic.mp3")
	
	BGMusic = $Music
	
func PlayButtonPress():
	$ButtonSound.play()
	
func StopBackgroundMusic():
	BGMusic.stop()

func PlayBackgroundMusic():
	if cur_music == Music.CAVE_MUSIC:
		BGMusic.stream = cave_music
	elif cur_music == Music.JUNGLE_MUSIC:
		BGMusic.stream = jungle_music
	elif cur_music == Music.HELL_MUSIC:
		BGMusic.stream = hell_music
	elif cur_music == Music.MENU_MUSIC:
		BGMusic.stream = menu_music
	else:
		print("BG AUDIO ERROR")
	
	print("Now Playing -> " + str(cur_music))
	
	BGMusic.play()

func IncrementMusic():
	if cur_music == Music.CAVE_MUSIC:
		cur_music = Music.JUNGLE_MUSIC
		
	elif cur_music == Music.JUNGLE_MUSIC:
		cur_music = Music.HELL_MUSIC
		
	else:
		print("Increment BG ERROR")

