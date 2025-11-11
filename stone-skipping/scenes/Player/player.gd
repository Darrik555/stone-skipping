class_name Player
extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var progress_bar: ProgressBar

#@onready var stone = $"../Stone"
@export var camera_3d: Camera3D

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


func throw():
	
	if throwableInventory.get_length() > 0:
		animation_player.play("arm_throw")
		
		#throw_direction = camera_3d.global_position.direction_to(stone.global_position)
		#throw_direction.y = -throw_direction.y * 0.2
		var forward_vector = -camera_3d.global_transform.basis.z.normalized()
		throw_direction = (forward_vector + Vector3(0, 0.2, 0)).normalized()
		get_parent().start_new_throw(throw_power, throw_direction)
		#stone.global_position = global_position
		
		#stone.velocity = throw_power * throw_direction
		#stone.stats.bounces = stone.stats.max_bounces
		#stone.get_node("CollisionShape3D").disabled = false
		#stone.get_node("State Machine").reset()
	
	#reset stuff
	progress_bar.value = 0.0
	throw_power = 0.0
	charging = true
	is_input_active = false
