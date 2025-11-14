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
	
	if not is_sunk:
		#move_and_slide()
		#maybe set water_collision to waveheight, could resolve unclean bouncing with height change
		#lerp(water_collider.global_position.y,ocean.global_position.y+ocean.get_wave_height(global_position),1.0)
		water_collider.global_position.y = ocean.global_position.y + ocean.get_wave_height(global_position)
		var new_collision = move_and_collide(velocity * _delta)
		#set player position in ocean, so offset of ripple etc., is updated
		$"../Ocean".set_player_position(global_position)
		
		
		#print($WaterCollision.global_position.y)
		
		if new_collision != null:
			collision = new_collision
			notify_water_hit()
		
		#var waveheight :float = $"../Ocean".get_wave_height(global_position)
		#if waveheight+stone_thickness >= global_position.y:
			##collision at global_position
			#collision_pos = global_position
			#
			#notify_water_hit()

func notify_water_hit():
	if not is_sunk:
		has_hit_water = true
		#test ripple, position/radius/strength
		$"../Ocean".add_wave(global_position,0.3,1.0)

func on_state_transition(new_state: String):
	if new_state == "Sunk":
		is_sunk = true
		velocity = Vector3.ZERO
		set_collision_mask_value(1,false)
		print("stone sunk")
