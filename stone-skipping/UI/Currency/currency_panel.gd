class_name CurrencyUI
extends PanelContainer

@export var currencyTexture: Texture
@onready var currency_amount: Label = %CurrencyAmount

func reload(currencyAmount: Currency):
	currency_amount.display(currencyAmount.get_currency())
