extends CharacterBody2D

func _physics_process(delta: float) -> void:
	
	position.y = move_toward(position.y, 0, 1)
	
	move_and_slide()
