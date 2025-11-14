extends CharacterBody3D

@export var stats: ThrowableStats
#TODO: add to stats, stat for water bouncing offset
@export var stone_thickness : float = 2.0


var is_sunk: bool = false
var has_hit_water: bool = false

@onready var state_machine: Node = $"State Machine"

var collision : KinematicCollision3D
var collision_pos : Vector3

var water_collider
var ocean

func _ready():
	stats.bounces = stats.max_bounces
	#start speed
	#velocity = Vector3(25.0, 3.0, 0.0)
	#maybe angle of throw
	#set_collision_layer_value(5, false)
	pass

func _physics_process(_delta: float) -> void:
	has_hit_water = false
	state_machine._physics_process(_delta)
	var h_velocity : Vector3 = Vector3(velocity.x,0,velocity.z)
	if h_velocity.length() > 1 and !is_sunk:
		rotate_y(_delta * velocity.length()* 10)
	if not is_sunk:
		water_collider.global_position.y = ocean.global_position.y + ocean.get_wave_height(global_position)
		var new_collision = move_and_collide(velocity * _delta)
		#set player position in ocean, so offset of ripple etc., is updated
		$"../Ocean".set_player_position(global_position)
		
		if new_collision != null:
			collision = new_collision
			notify_water_hit()
			print(collision)
		

func notify_water_hit():
	if not is_sunk:
		has_hit_water = true
		#test ripple, position/radius/strength
		#$"../Ocean".add_wave(global_position,10.0,1.0)
		$"../Ocean".add_ripple(global_position,1,1.0)
		print("water hit")

func on_state_transition(new_state: String):
	if new_state == "Sunk":
		is_sunk = true
		velocity = Vector3.ZERO
		set_collision_mask_value(1,false)
		print("stone sunk")
