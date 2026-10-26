extends TouchScreenButton


func _ready() -> void:
	get_viewport().size_changed.connect(_update_position)
	_update_position()

func _update_position() -> void:
	var screen_size = get_viewport_rect().size
	position = screen_size - Vector2(400, 450)
