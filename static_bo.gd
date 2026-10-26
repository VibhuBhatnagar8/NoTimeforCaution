extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter8.queue_free()
	%"11".emitting = true
	%Sound.play()
