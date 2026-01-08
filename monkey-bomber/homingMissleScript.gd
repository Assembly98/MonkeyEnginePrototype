extends Node2D

@onready var planebomb = $"../planeBomb"
var gridPos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass#if planebomb.timer.time_left == 0:
		#for gridSnapper in get_children():
			#gridPos = gridSnapper.position
	#else:
		#planebomb.visible = false
		#planebomb.position = Vector2(-100, 100)
			
