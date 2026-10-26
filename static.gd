extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter13.queue_free()
	%"12".emitting = true
	%Sound.play()
