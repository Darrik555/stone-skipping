extends Camera3D

@export var follow_speed: float = 4.0
@export var offset: Vector3 = Vector3(-8.0, 4.0, 0.0)
@export var look_at_offset: Vector3 = Vector3(0.0, 0.5, 0.0)

@export var target_node: Node3D

#camera stats
@export var camera_rotation_sensitivity : float = 0.001

func _ready():
	#target_node = %Player
	pass

func set_target(new_target: Node3D):
	target_node = new_target
	if is_instance_valid(target_node):
		global_position = get_target_position()

func get_target_position():
	if is_instance_valid(target_node):
		#fix velocity vector calculation, so that camera follow behind the stone
		# (maybe take camera global_position, as it gets set behind the stone at the start of throw)
		return target_node.global_position + (global_position - target_node.global_position).normalized() * 10.0 + Vector3(0,1,0)
		#return target_node.global_position - clamp((target_node.velocity * Vector3(1,0,1)),Vector3(0,0,-5),Vector3(0,0,5))# + offset
	return global_position

func _physics_process(delta: float) -> void:
	if is_instance_valid(target_node):
		var desired_position = get_target_position()
		#smooth camera position
		#var desired_position = global_position.lerp(get_target_position(), delta * 100)
		
		global_position = global_position.lerp(desired_position, delta * follow_speed)
		
		#look_at(target_node.global_position, Vector3.UP)
		var direction = target_node.global_position - global_position
		rotate_toward(rotation.z,global_position.angle_to(direction),delta)
		#figure out rotation on x axis/ rotate the camera down,
		#rotate_toward(rotation.x,global_position.angle_to(target_node.global_position),delta)
	
