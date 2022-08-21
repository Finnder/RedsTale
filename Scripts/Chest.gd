extends Node2D

var opened : bool = false

onready var weepingWomenSprite = preload("res://Assets/Art/Envirement/Collectable/WeepingWomen2.png")
onready var flowerSprite = preload("res://Assets/Art/Envirement/Collectable/Flower.png")
onready var jeneeSprite = preload("res://Assets/Art/Envirement/Collectable/Jenee.png")
onready var hoodSprite = preload("res://Assets/Art/Envirement/Collectable/RedHood.png")
onready var scriptureSprite = preload("res://Assets/Art/Envirement/Collectable/Scripture.png")
onready var snakeSprite = preload("res://Assets/Art/Envirement/Collectable/SnakePot.png")
onready var sunsetSprite = preload("res://Assets/Art/Envirement/Collectable/sunset.png")
onready var xylaphoneSprite = preload("res://Assets/Art/Envirement/Collectable/xylaphone.png")

enum Collectables {
	weepingWomen,
	flower,
	jenee,
	hood,
	scripture,
	snake,
	sunset,
	xylaphone
}

export var CollectableInside = Collectables.weepingWomen

func _ready():
# Collectable Check
		if CollectableInside == Collectables.weepingWomen:
			$Trinket.texture = weepingWomenSprite
		elif CollectableInside == Collectables.flower:
			$Trinket.texture = flowerSprite
		elif CollectableInside == Collectables.jenee:
			$Trinket.texture = jeneeSprite
		elif CollectableInside == Collectables.hood:
			$Trinket.texture = hoodSprite
		elif CollectableInside == Collectables.scripture:
			$Trinket.texture = scriptureSprite
		elif CollectableInside == Collectables.snake:
			$Trinket.texture = snakeSprite
		elif CollectableInside == Collectables.sunset:
			$Trinket.texture = sunsetSprite
		elif CollectableInside == Collectables.xylaphone:
			$Trinket.texture = xylaphoneSprite
			
		# Collectable Check
		if CollectableInside == Collectables.weepingWomen and ResourceManager.hasWeepingWomen:
			opened = true
		elif CollectableInside == Collectables.flower and ResourceManager.hasFlower:
			opened = true
		elif CollectableInside == Collectables.jenee and ResourceManager.hasJenee:
			opened = true
		elif CollectableInside == Collectables.hood and ResourceManager.hasHood:
			opened = true
		elif CollectableInside == Collectables.scripture and ResourceManager.hasScripture:
			opened = true
		elif CollectableInside == Collectables.snake and ResourceManager.hasSnake:
			opened = true
		elif CollectableInside == Collectables.sunset and ResourceManager.hasSunset:
			opened = true
		elif CollectableInside == Collectables.xylaphone and ResourceManager.hasXylaphone:
			opened = true
			
		if opened:
			$ChestOpened.show()
			$ChestClosed.hide()

func tryOpen():
	if !opened:
		$ChestOpened.show()
		$ChestClosed.hide()
		$OpenSound.play()
		$Trinket/TrinketAnimation.play("CollectedTrinket")
		opened = true
		print(CollectableInside)
		
		# Collectable Check
		if CollectableInside == Collectables.weepingWomen:
			ResourceManager.hasWeepingWomen = true
		elif CollectableInside == Collectables.flower:
			ResourceManager.hasFlower = true
		elif CollectableInside == Collectables.jenee:
			ResourceManager.hasJenee = true
		elif CollectableInside == Collectables.hood:
			ResourceManager.hasHood = true
		elif CollectableInside == Collectables.scripture:
			ResourceManager.hasScripture = true
		elif CollectableInside == Collectables.snake:
			ResourceManager.hasSnake = true
		elif CollectableInside == Collectables.sunset:
			ResourceManager.hasSunset = true
		elif CollectableInside == Collectables.xylaphone:
			ResourceManager.hasXylaphone = true
