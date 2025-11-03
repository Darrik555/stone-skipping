extends Camera3D

@export var follow_speed: float = 4.0
@export var offset: Vector3 = Vector3(-8.0, 4.0, 0.0)
@export var look_at_offset: Vector3 = Vector3(0.0, 0.5, 0.0)

@export var target_node: Node3D

func _ready():
	if not is_instance_valid(target_node):
		set_process(false)
		return

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target_node):
		return
	
	var desired_position = target_node.global_position + offset
	
	global_position = global_position.lerp(desired_position, delta * follow_speed)
	
	var look_at_point = target_node.global_position + look_at_offset
	look_at(look_at_point, Vector3.UP)
