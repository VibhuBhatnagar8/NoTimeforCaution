extends Button



func _on_pressed() -> void:
	get_tree().quit()
	%AudioStreamPlayer.play()
	%AudioStreamPlayer2.play()
