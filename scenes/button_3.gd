extends Button




func _on_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn")
	%AudioStreamPlayer.play()
	%AudioStreamPlayer2.play()
