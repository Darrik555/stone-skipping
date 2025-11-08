extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect

func display(throwable: Throwable):
	texture_rect.texture = throwable.icon
