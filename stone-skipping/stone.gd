extends RigidBody3D

@onready var stone_mesh = $StoneMesh
@onready var collision_shape_3d = $CollisionShape3D

#var velocity : Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	body_shape_entered.connect(on_collision)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func on_collision(_body):
	
	#water: handle bounce
	bounce()
	#obstacle
	
	pass

func bounce():
	#count down number of bounces left
	#emit bounced signal
	#
	pass
