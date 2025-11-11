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
		return target_node.global_position + offset
	return global_position

func _physics_process(delta: float) -> void:
	if is_instance_valid(target_node):
		var desired_position = get_target_position()
		
		global_position = global_position.lerp(desired_position, delta * follow_speed)
		
		look_at(target_node.global_position, Vector3.UP)
	
