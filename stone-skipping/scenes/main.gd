extends Node3D

@export var throwable:Throwable

func _ready():
	var instance = throwable.scene.instantiate()
	add_child(instance)
	$Camera3D.set_target(instance)
 
