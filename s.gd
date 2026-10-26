extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter10.queue_free()
	%"4".emitting = true
	%Sound.play()
