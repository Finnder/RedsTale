extends Node2D

var playerCanInteract : bool = false

var GoulTalking = ["Oh Hey!", "No... that would be my dad, he's actually on vacation at the moment...", "Yeah sure, but first you want some of these pomegranate seeds?", "Fine well suit yourself, more for me I guess.", "To the surface we go!"]
var PlayerTalking = ["Hey... are you hades?", "Uh... well I'm trying to get out of this stinkin cave. Can you help me?", "Uhh... no I think im good."]
var goulIndex = 0
var playerIndex = 0
var goulIsTalking = true

func Setup():
	$Camera2D.current = true
	$Player/FollowCamera.current = false
	$Player/talk.visible = false
	
	if GameManager.CurrentLevel == 25:
		$EnvirementProps/Goul/FToTalkSprite.visible = false
		playerCanInteract = false
		$Camera2D.zoom.x = 1
		$Camera2D.zoom.y = 1
		
		

func _ready():
	Setup()

func _process(delta):
		if Input.is_action_just_pressed("interact") and playerCanInteract and GameManager.CurrentLevel == 25:
			$Player.playerSpeed = 0
			$Player.grounded = false
			$EnvirementProps/Goul/FToTalkSprite.visible = false
			
			if goulIndex < len(GoulTalking) and goulIsTalking:
				$Player/talk.visible = false
				$EnvirementProps/Goul/talk.visible = true
				$EnvirementProps/Goul/talk.text = GoulTalking[goulIndex]
				goulIndex += 1
				
				if goulIndex != len(GoulTalking) - 1:
					goulIsTalking = false
					
				if goulIndex == len(GoulTalking):
					$Player/GUI/Overlay.visible = true
					$Player/GUI/Overlay/Panel/AnimationPlayer.play("EndGame")
					
				
			else: 
				if playerIndex < len(PlayerTalking):
					$Player/talk.visible = true
					$EnvirementProps/Goul/talk.visible = false
					$Player.get_node("talk").text = PlayerTalking[playerIndex]
					playerIndex += 1
					goulIsTalking = true
				
			

# last level
func _on_Area2D_body_entered(body):
	$Camera2D/AnimationPlayer.play("MoveR")


func _on_GoulArea2D_body_entered(body):
	if body.name == "Player":
		playerCanInteract = true
		$EnvirementProps/Goul/FToTalkSprite.visible = true


func _on_GoulArea2D_body_exited(body):
	if body.name == "Player":
		playerCanInteract = false
		$EnvirementProps/Goul/FToTalkSprite.visible = false
