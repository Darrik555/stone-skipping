class_name InventoryUI
extends PanelContainer

@export var slot_scene: PackedScene

@onready var grid_container: GridContainer = %GridContainer

func open(inventory: Inventory):
	show()
	
	for child in grid_container.get_children():
		child.queue_free()
	
	for throwableItem in inventory.get_throwables():
		var slot = slot_scene.instantiate()
		grid_container.add_child(slot)
		slot.display(throwableItem)
