extends Area3D


@onready var player: CharacterBody3D = %Player


func _on_body_entered(body: Node3D) -> void:
	if body == %Player:
		%Panel.visible = true
		%"game over".play("RESET")
		%Debris.emitting = true
		%explode.play()
		%Fire.emitting = true
		%Robot.visible = false
		player.set_physics_process(false)
