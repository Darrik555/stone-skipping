extends State
class_name StoneSunk

var stone_controller: CharacterBody3D

func Enter():
	if get_parent() and get_parent().get_parent():
		stone_controller = get_parent().get_parent()
	
	#disable collision
	#maybe only disable collision with water (the specific collision layer)
	stone_controller.get_node("CollisionShape3D").disabled = true
	
	#start timer, despawn/reset
	
	print("Sunk")

func Exit():
	print("Left Sunk (huh?)")

func Physics_Update(_delta: float):
	
	stone_controller.velocity.y -= stone_controller.gravity * _delta
	pass
