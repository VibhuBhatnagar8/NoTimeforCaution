extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter5.queue_free()
	%"8".emitting = true
	%Sound.play()
