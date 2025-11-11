class_name Player
extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var progress_bar: ProgressBar

#@onready var stone = $"../Stone"
@export var camera_3d: Camera3D
@onready var camera_arm : Node3D = $CameraArm
@onready var camera_3d_player : Camera3D = $CameraArm/Camera3D
@export var camera_rotation_sensitivity : float = 0.001
@export var SPEED : float = 10.0

var throw_power : float = 0.0
var throw_direction : Vector3 = Vector3(1,0.1,1)
var charging : bool = true
var is_input_active: bool = false

var throwableInventory: Inventory = Inventory.new()
var relicInventory: Inventory = Inventory.new()

#for convenience
@export var throwable: Item
@export var relic: Item
func _ready():
	throwableInventory.add_item(throwable)
	throwableInventory.add_item(throwable)
	throwableInventory.add_item(throwable)
	throwableInventory.add_item(throwable)
	throwableInventory.add_item(throwable)
	relicInventory.add_item(relic)
#for convenience end

func consume_throwable() -> bool:
	if throwableInventory.get_length() > 0:
		throwableInventory.remove_item(throwableInventory.get_items()[0])
		#print("Stones ", throwableInventory.get_length())
		return true
	return false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("leftclick"):
		if throwableInventory.get_length() <= 0:
			return
		
		is_input_active = true
		throw_power = 0.0
	elif event.is_action_released("leftclick"):
		if is_input_active:
			throw()
		is_input_active = false
	
	#camera movement
	#Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and 
	if event is InputEventMouseMotion:
		var next_rotation = -event.screen_relative * camera_rotation_sensitivity
		rotate_y(next_rotation.x)
		var next_camera_rotation = clamp(camera_arm.rotation.x + next_rotation.y,-1.5,1.5)
		
		#$Camera3D.rotate_x(next_rotation.y)
		camera_arm.rotation.x = next_camera_rotation
		#print(next_rotation.y)
		


func _process(delta):
	if is_input_active:
		#start_throw()
		#start power bar, 
		#when mousebutton released, pick number from power bar
		#calculate/set speed and angle of stone
		if throw_power >= progress_bar.max_value:
			charging = false
		elif throw_power <= 0.0:
			charging = true
		
		var charge_rate = progress_bar.max_value * delta
		
		if charging:
			throw_power += charge_rate
		else:
			throw_power -= charge_rate
		
		progress_bar.value = throw_power
	
	# Add the gravity.
	if not is_on_floor():
		pass
		#velocity += get_gravity() * delta# * 1.5
	
	#player movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()

func throw():
	if throwableInventory.get_length() > 0:
		animation_player.play("arm_throw")
		await animation_player.animation_finished
		
		throw_direction = -global_transform.basis.z
		get_parent().start_new_throw(throw_power, throw_direction)
		#stone.global_position = global_position
		
		#stone.velocity = throw_power * throw_direction
		#stone.stats.bounces = stone.stats.max_bounces
		#stone.get_node("CollisionShape3D").disabled = false
		#stone.get_node("State Machine").reset()
	
	#reset stuff
	animation_player.play("RESET")
	progress_bar.value = 0.0
	throw_power = 0.0
	charging = true
	is_input_active = false
