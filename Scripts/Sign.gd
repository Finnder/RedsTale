extends Node2D

export var signMessage : String = ""

func _ready():
	$UpgradeScroll/Label.text = signMessage
	$UpgradeScroll.hide()

func _on_Area2D_area_entered(area):
	$UpgradeScroll.show()
	$UpgradeScroll/AnimationPlayer.play("appear")


func _on_Area2D_area_exited(area):
	$UpgradeScroll/AnimationPlayer.play("disappear")
