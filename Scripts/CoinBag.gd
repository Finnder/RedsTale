extends Node2D

var coinsInBag : Array = []

func _ready():
	pass

func _on_Area2D_area_entered(area):
	if area:
		coinsInBag.append(area.get_parent())
