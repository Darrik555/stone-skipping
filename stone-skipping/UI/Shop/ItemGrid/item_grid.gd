class_name ItemGrid
extends GridContainer

@export var slot_scene: PackedScene

func display(throwableItems: Array[Throwable]):
	
	for child in get_children():
		child.queue_free()
	
	for item in throwableItems:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(item)
