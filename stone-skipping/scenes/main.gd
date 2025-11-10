extends Node3D

@export var throwable: Throwable

@onready var camera_3d: Camera3D = $Camera3D

var current_throwable: CharacterBody3D = null

func _ready():
	pass
 
func start_new_throw(power: float, direction: Vector3, player: Player):
	if not player.consume_throwable():
		#print("inv empty")
		return
	
	if is_instance_valid(current_throwable):
		current_throwable.queue_free()
	
	current_throwable = throwable.scene.instantiate() as CharacterBody3D
	add_child(current_throwable)
	current_throwable.global_position = player.global_position
	
	if camera_3d:
		if camera_3d.has_method("set_target"):
			camera_3d.set_target(current_throwable)
	
	current_throwable.velocity = power * direction
