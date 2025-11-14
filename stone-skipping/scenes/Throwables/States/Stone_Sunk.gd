extends State
class_name StoneSunk

var stone_controller: CharacterBody3D

func Enter():
	if get_parent() and get_parent().get_parent():
		stone_controller = get_parent().get_parent()
	print("entered Sunk state")
	
	stone_controller.velocity = Vector3.ZERO
	
	#disable water collision mask:
	stone_controller.set_collision_mask_value(2,false)
	
	#splash effect
	$"../../../Ocean".add_wave(stone_controller.global_position,2.0,2.0)
	#start timer, despawn/reset
	
	get_tree().create_timer(1).timeout.connect(stone_controller.queue_free)
	

func Exit():
	#stone_controller.get_node("CollisionShape3D").disabled = false
	print("Left Sunk (huh?)")

func Physics_Update(_delta: float):
	stone_controller.velocity.y -= stone_controller.stats.gravity * _delta
	pass
