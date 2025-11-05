extends Node3D

@onready var animation_player : AnimationPlayer = $"../AnimationPlayer"
@onready var progress_bar : ProgressBar = $"../CanvasLayer/ProgressBar"

@onready var stone = $"../Stone"
@onready var camera_3d = $"../Camera3D"


var throw_power : float = 0.0
var throw_direction : Vector3 = Vector3(1,0.1,1)
var charging : bool = true



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("leftclick"):
		#start_throw()
		#start power bar, 
		#when mousebutton released, pick number from power bar
		#calculate/set speed and angle of stone
		if throw_power >= progress_bar.max_value:
			charging = false
		elif throw_power <= 0.0:
			charging = true
		
		if charging:
			throw_power += 100 * _delta
		else:
			throw_power -= 100 * _delta
		
		progress_bar.value = throw_power
	
	if Input.is_action_just_released("leftclick"):
		throw()
	pass

func throw():
	
	throw_direction = camera_3d.global_position.direction_to(stone.global_position)
	throw_direction.y = -throw_direction.y *0.2
	
	stone.global_position = global_position
	
	stone.velocity = throw_power * throw_direction
	stone.bounces = stone.max_bounces
	stone.get_node("CollisionShape3D").disabled = false
	stone.get_node("State Machine").reset()
	
	#reset stuff
	progress_bar.value = 0.0
	throw_power = 0.0
