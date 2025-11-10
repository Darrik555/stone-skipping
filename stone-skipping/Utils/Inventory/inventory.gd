class_name Inventory

var _content: Array[Item] = []


func add_item(item: Item):
	_content.append(item)
	

func remove_item(item: Item):
	_content.erase(item)
	

func get_items() -> Array[Item]:
	return _content

func get_length() -> int:
	return len(_content)

func get_items_of_type(type_name: String) -> Array[Item]:
	var filtered_items: Array[Item] = []
	for item in _content:
		if item.is_class(type_name):
			filtered_items.append(item)
	return filtered_items
