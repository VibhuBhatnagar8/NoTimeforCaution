extends Button



func _ready() -> void:
	await get_tree().create_timer(5).timeout
	%dissapear.play("RESET")
	
	
