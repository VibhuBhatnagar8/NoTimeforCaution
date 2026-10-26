extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter9.queue_free()
	%"5".emitting = true
	%Sound.play()
