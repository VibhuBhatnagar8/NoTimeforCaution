extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter4.queue_free()
	%"6".emitting = true
	%Sound.play()
