
extends Area3D

@onready var batter_2: Node3D = %Batter2

func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	%Batter6.queue_free()
	%"bat6 particle".emitting = true
	%Sound.play()
