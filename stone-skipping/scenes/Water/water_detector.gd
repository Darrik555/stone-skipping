extends Area3D
#deprecated
func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and body.is_in_group("stone"):
		
		#body.notify_water_hit()
		
		print("water hit on area3d")
