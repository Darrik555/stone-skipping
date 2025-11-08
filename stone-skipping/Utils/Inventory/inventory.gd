class_name ThrowableInventory

var _content: Array[Throwable] = []


func add_throwable(throwable: Throwable):
	_content.append(throwable)
	

func remove_throwable(throwable: Throwable):
	_content.erase(throwable)
	

func get_throwables() -> Array[Throwable]:
	return _content

func get_length() -> int:
	return len(_content)
