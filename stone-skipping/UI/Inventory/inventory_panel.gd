class_name InventoryUI
extends PanelContainer

@export var slot_scene: PackedScene

@onready var grid_container: ItemGrid = %GridContainer

func reload(throwableInventory: ThrowableInventory):
	#show()
	grid_container.display(throwableInventory.get_throwables())
