class_name Currency
extends Resource

@export var currency: int = 0

func set_currency(amount: int):
	currency = amount

func get_currency() -> int:
	return currency

func add_currency(amount: int):
	currency += amount

func subtract_currency(amount: int):
	currency -= amount
