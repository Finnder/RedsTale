extends Control

func _ready():
	$Panel/AnimationPlayer.play("LastScene")


func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
