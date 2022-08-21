extends Node2D

const BuildingState = {
	NOT_UPGRADED = 0,
	UPGRADE_01 = 1,
	UPGRADE_02 = 2,
	UPGRADE_03 = 3
}  

const Building = {
	KingsQuarters = 0,
	BlackSmithsQuarters = 1
}

export var cur_building = Building.KingsQuarters
export var buildingLevel = BuildingState.NOT_UPGRADED


func _ready():
	SetBuildingUpgrade(buildingLevel)
	SetBuilding()

func SetBuilding():
	if cur_building == Building.KingsQuarters:
		$KingsQuarters.show()
		$KingsQuarters/AmbientNoise.play()
		
	elif cur_building == Building.BlackSmithsQuarters:
		$BlackSmithsQuarters.show()
		$BlackSmithsQuarters/AmbientNoise.play()
	
func SetBuildingUpgrade(state : int):
	# IF KINGS QUARTERS
	if cur_building == Building.KingsQuarters:
		if state == BuildingState.NOT_UPGRADED:
			HideAll(cur_building)
			$KingsQuarters/NoneUpgraded.show()
		elif state == BuildingState.UPGRADE_01:
			HideAll(cur_building)
			$KingsQuarters/Upgrade01.show()
		elif state == BuildingState.UPGRADE_02:
			HideAll(cur_building)
			$KingsQuarters/Upgrade02.show()
		elif state == BuildingState.UPGRADE_03:
			HideAll(cur_building)
			$KingsQuarters/Upgrade03.show()
		
	# IF BLACKSMITH
	if cur_building == Building.BlackSmithsQuarters:
		
		$BlackSmithsQuarters/NPC.show()
		
		if state == BuildingState.NOT_UPGRADED:
			$BlackSmithsQuarters/NoneUpgraded.show()
		elif state == BuildingState.UPGRADE_01:
			HideAll(cur_building)
			$BlackSmithsQuarters/Upgrade01.show()
		elif state == BuildingState.UPGRADE_02:
			HideAll(cur_building)
			$BlackSmithsQuarters/Upgrade02.show()
		elif state == BuildingState.UPGRADE_03:
			HideAll(cur_building)
			$BlackSmithsQuarters/Upgrade03.show()
			

func HideAll(buildingnum : int):
	if buildingnum == Building.KingsQuarters:
		for i in $KingsQuarters.get_child_count() - 1:
			get_child(i).hide()
				
	elif buildingnum == Building.BlackSmithsQuarters:
		for i in $BlackSmithsQuarters.get_child_count() - 2:
			get_child(i).hide()
		
func PlayerEnteredBuildingZone():
	if cur_building == Building.KingsQuarters:
		$KingsQuarters/UpgradeScroll.show()
		$KingsQuarters/UpgradeScroll/AnimationPlayer.play("appear")
		
	elif cur_building == Building.BlackSmithsQuarters:
		$BlackSmithsQuarters/UpgradeScroll.show()
		$BlackSmithsQuarters/UpgradeScroll/AnimationPlayer.play("appear")

func PlayerExitedBuildingZone():
	if cur_building == Building.KingsQuarters:
		$KingsQuarters/UpgradeScroll/AnimationPlayer.play("disappear")
		
	elif cur_building == Building.BlackSmithsQuarters:
		$BlackSmithsQuarters/UpgradeScroll/AnimationPlayer.play("disappear")


# AREA 2D Colliders
func _on_BuildingArea_body_entered(body):
	PlayerEnteredBuildingZone()

func _on_BuildingArea_body_exited(body):
	PlayerExitedBuildingZone()
