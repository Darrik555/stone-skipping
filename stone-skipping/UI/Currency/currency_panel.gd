class_name CurrencyUI
extends PanelContainer

@export var currencyTexture: Texture
@onready var currency_amount: Label = %CurrencyAmount

var tween_currency : Tween

func reload(currencyAmount: Currency):
	currency_amount.display(currencyAmount.get_currency())

func _on_currency_updated(new_currency: int):
	#currency_amount.text = "%s" % new_currency
	if tween_currency:
		tween_currency.kill()
	tween_currency = get_tree().create_tween()
	tween_currency.set_parallel().tween_property(currency_amount,"text","Points: %s " % new_currency,0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
