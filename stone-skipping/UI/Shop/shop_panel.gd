class_name ShopPanel
extends PanelContainer

@export var slot_scene: PackedScene

@onready var throwable_list: ItemList = %ThrowableList
@onready var throwable_container: ItemGrid = %ThrowableContainer
@onready var buy_button: Button = %BuyButton

var _inventory: Inventory
var _currency: int
var _selected_item: Item

func open(items: Array[Item], inventory: Inventory, currency: int):
	_inventory = inventory
	_currency = currency
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	throwable_list.clear()
	for item in items:
		var index = throwable_list.add_item(item.name)
		throwable_list.set_item_metadata(index, item)
	
	throwable_list.select(0)
	_on_throwable_list_item_selected(0)

func _on_throwable_list_item_selected(index: int) -> void:
	_selected_item = throwable_list.get_item_metadata(index)
	
	buy_button.disabled = _currency < _selected_item.price
	#throwable_container.display(throwable)


func _on_close_button_pressed() -> void:
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_buy_button_pressed() -> void:
	if _selected_item.price <= _currency and len(_inventory.get_items()) < 5:
		_inventory.add_item(_selected_item)
