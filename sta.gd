extends Area3D
func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter3.queue_free()
	%"7".emitting = true
	%Sound.play()
