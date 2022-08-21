extends AnimatedSprite

enum OrbType {
	JumpReturn, # Once you gain this orb, your jump is returned back to you and you can jump again
	SpeedBoost,
	Gravity
}

# Gravity Change Config
var gravityChange : int = 18
var gravityChangeTime : int = 5

# Speed Orb Config
var speedChange : int = 175
var speedChangeTime : int = 5


export var playerColorChange : Color = Color(1, 0.25, 0.07) # Default is JumpReturn one

export var jumpandspeedColor : Color = Color(1, 1, 1)
export var jumpandgravityColor : Color = Color(1, 1, 1)
export var speedandgravityColor : Color = Color(1, 1, 1)

var playerEffected
export var orbType = OrbType.JumpReturn

func _ready() -> void:
	if orbType == OrbType.SpeedBoost:
		 $Timer.wait_time = speedChangeTime
	elif orbType == OrbType.Gravity:
		 $Timer.wait_time = gravityChangeTime
	elif orbType == OrbType.JumpReturn:
		pass
		
func onPlayerConsume(player : KinematicBody2D) -> void:
	player.sprite.frames = player.specialAnim
	if orbType == OrbType.JumpReturn:
		playerEffected = player
		player.grounded = true
		player.sprite.modulate = playerColorChange
		player.hasJumpReturnOrb = true 
		player.currentJumpAmount = 2
		
		if player.hasSpeedBoostOrb:
			player.sprite.modulate = jumpandspeedColor
		
	elif orbType == OrbType.SpeedBoost:
		$Timer.start()
		playerEffected = player
		player.sprite.modulate = playerColorChange
		player.hasSpeedBoostOrb = true 
		player.playerSpeed += speedChange 
		
	elif orbType == OrbType.Gravity:
		$Timer.start()
		playerEffected = player
		player.sprite.modulate = playerColorChange
		player.gravity = gravityChange
		
	queue_free()
	
func _on_Timer_timeout():
	playerEffected.playerSpeed = playerEffected.basePlayerSpeed
	playerEffected.gravity = playerEffected.basePlayerGravity
	playerEffected.sprite.modulate = Color(1, 1, 1)
	print("yo")
