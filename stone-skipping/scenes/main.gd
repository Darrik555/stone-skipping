extends Node3D

@export var throwable: Item

@onready var player: Player = %Player
@onready var camera_3d: Camera3D = $Camera3D
@onready var player = %Player

var current_throwable: CharacterBody3D = null

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		reset_camera()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func start_new_throw(power: float, direction: Vector3):
	if not player.consume_throwable():
		#print("inv empty")
		return
	
	if is_instance_valid(current_throwable):
		current_throwable.queue_free()
	
	
	current_throwable = throwable.scene.instantiate() as CharacterBody3D
	add_child(current_throwable)
	
	for relic in player.relicInventory.get_items():
		if relic.has_method("apply_effect"):
			relic.apply_effect(current_throwable)
	
	current_throwable.global_position = player.global_position
	
	if camera_3d:
		if camera_3d.has_method("set_target"):
			camera_3d.set_target(current_throwable)
			camera_3d.current = true
	
	current_throwable.velocity = power * direction

func reset_camera():
	#camera_3d.set_target(player)
	player.camera_3d_player.current = true
