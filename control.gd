extends Control

func _ready() -> void:
	%Panel.visible = false


	

func _on_button_pressed() -> void:
	%BatterySound.pitch_scale = randf_range(0.7, 0.9)
	%Sound.play()
	%BatterySound.play()
	SceneTransition.change_scene("res://scenes/main.tscn")
	GameManager.score = 0
	

func _on_button_2_pressed() -> void:
	%BatterySound.pitch_scale = randf_range(0.9, 1.1)
	%Sound.play()
	%BatterySound.play()
	SceneTransition.change_scene("res://scenes/menu.tscn")
	GameManager.score = 0
