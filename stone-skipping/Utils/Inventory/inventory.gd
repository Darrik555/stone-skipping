class_name Inventory

var _content: Array[Throwable] = []


func add_throwable(throwable: Throwable):
	_content.append(throwable)
	

func remove_throwable(throwable: Throwable):
	_content.erase(throwable)
	

func get_throwables() -> Array[Throwable]:
	return _content
