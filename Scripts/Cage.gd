extends Node2D

onready var sprite01 : StreamTexture = preload("res://Assets/IMPORTS/Lively NPCs - medieval_32x32/individual sprites/beggar/beggar_00.png")
onready var sprite02 : StreamTexture = preload("res://Assets/IMPORTS/Lively NPCs - medieval_32x32/individual sprites/dog/dog_1.png")
onready var sprite03 : StreamTexture = preload("res://Assets/IMPORTS/Lively NPCs - medieval_32x32/individual sprites/elder/elder_1.png")
onready var sprite04 : StreamTexture = preload("res://Assets/IMPORTS/Lively NPCs - medieval_32x32/individual sprites/farmer_02/farmer_02_1.png")

onready var sprites : Array = [sprite01, sprite02, sprite03, sprite04]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var my_rn = rng.randi_range(0, len(sprites) - 1)
	
	$RandomPerson.texture = sprites[my_rn]
	
	
