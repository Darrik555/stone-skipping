extends CharacterBody3D

@export var stats: ThrowableStats

var is_sunk: bool = false
var has_hit_water: bool = false

@onready var state_machine: Node = $"State Machine"

var collision : KinematicCollision3D

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
		var new_collision = move_and_collide(velocity * _delta)
		#set player position in ocean, so offset of ripple etc., is updated
		$"../Ocean".set_player_position(global_position)
		if new_collision != null:
			collision = new_collision
			notify_water_hit()
			#print("collision and water hit")

func notify_water_hit():
	if not is_sunk:
		has_hit_water = true
		#test ripple, position/radius/strength
		$"../Ocean".add_ripple(global_position,1.0,2.0)

func on_state_transition(new_state: String):
	if new_state == "Sunk":
		is_sunk = true
		velocity = Vector3.ZERO
		set_collision_mask_value(1,false)
		print("stone sunk")
