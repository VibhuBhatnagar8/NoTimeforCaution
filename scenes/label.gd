extends Label

@onready var player: CharacterBody3D = %Player
var is_victory: bool = false # Prevents repeating every frame

func _process(delta: float) -> void:
	if GameManager.score == 12 and not is_victory:
		is_victory = true 
		
		text = " VICTORY"
		%Panel.visible = true
		%"game over".play("RESET") 
		%Robot.visible = false
		player.set_physics_process(false)
