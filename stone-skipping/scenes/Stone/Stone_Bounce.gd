extends State
class_name StoneBounce

var stone_controller: CharacterBody3D

func Enter():
	
	
	if get_parent() and get_parent().get_parent():
		stone_controller = get_parent().get_parent()
	
	if not stone_controller or stone_controller.is_sunk:
		return
	
	var horizontal_velocity = Vector3(stone_controller.velocity.x, 0.0, stone_controller.velocity.z)
	var horizontal_speed_sq = horizontal_velocity.length_squared()
	
	var angle = deg_to_rad(2.0)
	
	var lift_force = horizontal_speed_sq * stone_controller.lift_factor * sin(angle)
	
	# Vertical velocity the actual skip
	#stone_controller.velocity.y = lift_force
	
	#bounce the velocity off of the (water plane) collision point
	stone_controller.velocity = stone_controller.velocity.bounce(stone_controller.collision.get_normal())
	
	
	# energy loss
	stone_controller.velocity.y *= 0.8
	stone_controller.velocity.x *= (1.0 - stone_controller.friction_factor)
	stone_controller.velocity.z *= (1.0 - stone_controller.friction_factor)
	
	
	
	
	#decide termination
	stone_controller.bounces -= 1
	#print("Bounced, bounces left: ",stone_controller.bounces)
	if stone_controller.bounces <= 0:
		Transitioned.emit(self,"Sunk")
	else:
		Transitioned.emit(self,"InAir")

func Exit():
	#print("bounce exit")
	pass

func Physics_Update(_delta: float):
	pass
