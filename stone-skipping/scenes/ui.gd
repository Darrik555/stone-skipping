extends CanvasLayer

@export var all_throwables: ResourceGroup

@onready var player: Player = %Player
@onready var inventory_panel: InventoryUI = %InventoryPanel
@onready var relic_inventory_panel = %RelicInventoryPanel
@onready var shop_panel: ShopPanel = %ShopPanel

var _all_throwables: Array[Item] = []

func _ready():
	all_throwables.load_all_into(_all_throwables)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("Shop"):
		if shop_panel.visible:
			shop_panel.hide()
		else:
			shop_panel.open(_all_throwables, player.throwableInventory, player.current_currency.getCurrency())
		
	

func _process(_delta: float) -> void:
	inventory_panel.reload(player.throwableInventory)
	relic_inventory_panel.reload(player.relicInventory)
