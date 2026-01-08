extends CharacterBody2D

@export var speed = 1500

var direction : float
var spawnPos : Vector2
var spawnRot : float

func _ready() -> void:
	global_position = spawnPos-Vector2(0, 10)
	global_rotation = spawnRot

func _physics_process(delta: float) -> void:
	velocity = Vector2(-speed, 0)#.rotated(direction)
	move_and_slide()
		


func _on_timer_timeout() -> void:
	queue_free()
