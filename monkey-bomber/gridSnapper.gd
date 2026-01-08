extends Area2D


@export var player : CharacterBody2D
@onready var planeBomb  = $"../../planeBomb"
var lastPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if player.position != position:
			player.position.x = move_toward(player.position.x, position.x, 200)
			player.position.y = move_toward(player.position.y, position.y, 200)
			planeBomb.position.x = move_toward(planeBomb.position.x, position.x, 200)
			planeBomb.position.y = move_toward(planeBomb.position.y, position.y, 200)
			#print('true')
			#print(player.position.x)
			
