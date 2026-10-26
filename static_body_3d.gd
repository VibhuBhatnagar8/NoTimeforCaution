extends Area3D

@onready var batter_2: Node3D = %Batter2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	GameManager._add()
	%BatterySound.play()
	batter_2.queue_free()
	%"bat6 particle2".emitting = true
	%Sound.play()
