extends Label

func _process(delta: float) -> void:
	text = "X " + str(GameManager.score)
