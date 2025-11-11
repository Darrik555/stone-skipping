class_name RelicLeaf
extends Item

@export var drag_reduction_factor: float = 0.8

func apply_effect(throwable_controller: CharacterBody3D):
	if throwable_controller:
		throwable_controller.stats.drag *= drag_reduction_factor
		print("effect applied")
	
