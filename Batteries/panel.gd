extends Panel

func _ready() -> void:
	%Panel.visible = false
		
func _process(delta: float) -> void:
	if %Panel.visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
