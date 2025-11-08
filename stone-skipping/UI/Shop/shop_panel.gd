class_name ShopPanel
extends PanelContainer

@export var slot_scene: PackedScene

@onready var throwable_list: ItemList = %ThrowableList
@onready var throwable_container: ItemGrid = %ThrowableContainer
@onready var buy_button: Button = %BuyButton

var _throwableInventory: ThrowableInventory
var _currency: int
var _selected_item: Throwable

func open(throwables: Array[Throwable], throwableInventory: ThrowableInventory, currency: int):
	_throwableInventory = throwableInventory
	_currency = currency
	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	throwable_list.clear()
	for throwable in throwables:
		var index = throwable_list.add_item(throwable.name)
		throwable_list.set_item_metadata(index, throwable)
	
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
	if _selected_item.price <= _currency and len(_throwableInventory.get_throwables()) < 5:
		_throwableInventory.add_throwable(_selected_item)
