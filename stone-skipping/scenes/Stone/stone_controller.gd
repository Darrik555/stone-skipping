extends CharacterBody3D

@export var gravity: float = 9.81
@export var drag: float = 0.01
@export var lift_factor: float = 0.7
@export var friction_factor: float = 0.2
@export var sink_speed_threshold: float = 5.0
@export var bounces : int = 10
@export var max_bounces : int = 15

var is_sunk: bool = false
var has_hit_water: bool = false

@onready var state_machine: Node = $"State Machine"

var collision : KinematicCollision3D

func _ready():
	#start speed
	#velocity = Vector3(25.0, 3.0, 0.0)
	#maybe angle of throw
	pass

func _physics_process(_delta: float) -> void:
	has_hit_water = false
	state_machine._physics_process(_delta)
	
	if not is_sunk:
		#move_and_slide()
		var new_collision = move_and_collide(velocity * _delta)
		if new_collision != null:
			collision = new_collision
			notify_water_hit()
			print("collision and water hit")

func notify_water_hit():
	if not is_sunk:
		has_hit_water = true

func on_state_transition(new_state: String):
	if new_state == "Sunk":
		is_sunk = true
		velocity = Vector3.ZERO
		set_collision_mask_value(1,false)
		print("stone sunk")
