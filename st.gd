extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter11.queue_free()
	%"3".emitting = true
	%Sound.play()
