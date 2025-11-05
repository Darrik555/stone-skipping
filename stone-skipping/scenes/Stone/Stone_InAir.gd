extends State
class_name StoneInAir

var stone_controller: CharacterBody3D

func Enter():
	if get_parent() and get_parent().get_parent():
		stone_controller = get_parent().get_parent()
		stone_controller.get_node("CollisionShape3D").disabled = false
	#print("entered air")

func Exit():
	#print("left air")
	pass

func Physics_Update(_delta: float):
	if not stone_controller or stone_controller.is_sunk:
		return
	
	# Gravity and Air Drag
	stone_controller.velocity.y -= stone_controller.gravity * _delta
	
	var drag = -stone_controller.velocity.normalized() * stone_controller.velocity.length_squared() * stone_controller.drag * _delta
	stone_controller.velocity += drag
	
	if stone_controller.has_hit_water:
		Transitioned.emit(self,"Bounce")
