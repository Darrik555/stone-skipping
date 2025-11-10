class_name InventoryUI
extends PanelContainer

@export var slot_scene: PackedScene

@onready var grid_container: ItemGrid = %GridContainer

func reload(inventory: Inventory):
	#show()
	grid_container.display(inventory.get_items())
