extends KinematicBody2D

# Init
onready var sprite : AnimatedSprite = $AnimatedSprite

onready var normalAnim = preload("res://Assets/Animations/PlayerAnimSprite.tres")
onready var specialAnim = preload("res://Assets/Animations/SpecialAnimSprite.tres")

# Player Configs
export var playerSpeed : int = 250
export var startjumpAmount = 1
export var jump_force = 450
export var gravity = 40

# PLAYER CONSTANTS
const MAX_FALL_SPEED = 900

# Player
var basePlayerSpeed : int = playerSpeed
var MAX_SPEED = 350
var grounded : bool = false
var canJump : bool = false

# Orbs
var hasJumpReturnOrb : bool = false
var hasSpeedBoostOrb : bool = false


onready var currentJumpAmount = startjumpAmount

# Anim stuff
var playingWalk : bool = false
var playingJump : bool = false
var landEffectPlayed : bool = false

# Other
var vel = Vector2.ZERO
var baseGravity = gravity

func _ready():
	if GameManager.SpeedRunTimerCurrent <= 0.01:
		$GUI/SpeedRunTimer.StartSpeedRunTimer()
	else:
		$GUI/SpeedRunTimer/SpeedRunPanel/Timer.text = str(GameManager.SpeedRunTimerCurrent)
		$GUI/SpeedRunTimer/speedrun_timer.start()
		
	if GameManager.CurrentLevel >= 25:
		$GUI/SpeedRunTimer/speedrun_timer.paused = true
		$GUI/SpeedRunTimer/SpeedRunPanel/Timer.modulate = Color("#ffef43")

func _physics_process(delta):
	movement(delta)
	restart()

# Player Movement Handling
func movement(delta):
	var move_dir_x = move_direction()
	
	if vel.y < MAX_FALL_SPEED:
		vel.y += gravity
	
	vel.x = move_dir_x.x * (playerSpeed)
	
	# Jump 
	if Input.is_action_just_pressed("jump") && grounded && currentJumpAmount > 0:
		vel.y = -jump_force
		currentJumpAmount -= 1
		$Sounds/Jumping.play()
	
	vel = move_and_slide(vel)
	
	if vel.y < 0:
		sprite.play("PlayerJump")
		if playingWalk: 
			$Sounds/CaveWalking.stop()
			playingWalk = false
		
			
	elif vel.y > 0:
		sprite.play("PlayerFall")
		if playingWalk: 
			$Sounds/CaveWalking.stop()
			playingWalk = false
	
	# Animations
	if vel.x < 0:
		if grounded: 
			whenRun()
			sprite.flip_h = true
		else:
			sprite.flip_h = true
	elif vel.x > 0:
		if grounded: 
			whenRun()
			sprite.flip_h = false
		else:
			sprite.flip_h = false	
	else:
		if grounded: 
			sprite.play("PlayerIdle")
			if playingWalk: 
				$Sounds/CaveWalking.stop()
				playingWalk = false
	
func whenRun():
	sprite.play("PlayerRun")
	if !playingWalk:
		$Sounds/CaveWalking.play()
		playingWalk = true
		
func whenJump():
	if playingWalk: 
		$Sounds/CaveWalking.stop()
		playingWalk = false
		
func OnLand():
	grounded = true
	currentJumpAmount = startjumpAmount
	$Effects.play("jumpeffect")
	$Effects.frame = 0
	if hasJumpReturnOrb:
		if hasSpeedBoostOrb:
			pass
		else:
			resetPlayer()
		
	
func resetPlayer():
	sprite.modulate = Color(1, 1, 1)
	sprite.self_modulate = Color(1, 1, 1)
	sprite.frames = normalAnim
	
func move_direction() -> Vector2: return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 0)

func restart():
	if Input.action_press("restart"):
		LevelChanger.resetLevel()

func _on_OnGroundArea_body_entered(body) -> void:
	if body.name == "WallTiles": 
		grounded = false
		
	if body.name == "WalkingTiles": 
		OnLand()
	
	if body.name == "DeathTiles":
		LevelChanger.resetLevel()
	
func _on_OnGroundArea_body_exited(body):
	if body.name == "WalkingTiles": grounded = false

func _on_InteractionArea_area_entered(area) -> void:
	
	if area.name == "chestarea": 
		area.get_parent().tryOpen()
		
	elif area.name == "OrbArea":
		area.get_parent().onPlayerConsume(get_node("."))


func _on_InteractionArea_body_entered(body) -> void:
	if body.name == "DeathTiles":
		LevelChanger.resetLevel()


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Hell/End.tscn")
