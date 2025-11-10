extends State
class_name StoneSunk

var stone_controller: CharacterBody3D

func Enter():
	if get_parent() and get_parent().get_parent():
		stone_controller = get_parent().get_parent()
	print("entered Sunk state")
	
	#disable water collision mask:
	stone_controller.set_collision_mask_value(2,false)
	
	#splash effect
	$"../../../Ocean".add_ripple(stone_controller.global_position,3.0,4.0)
	#start timer, despawn/reset

func Exit():
	#stone_controller.get_node("CollisionShape3D").disabled = false
	print("Left Sunk (huh?)")

func Physics_Update(_delta: float):
	
	stone_controller.velocity.y -= stone_controller.stats.gravity * _delta
	pass
