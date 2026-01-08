extends AnimatedSprite2D

@onready var detonationText = $TextEdit
@onready var anim = $AnimationPlayer
@onready var bombTime = $TextEdit2

var bombTimeInt : float = 150
var animSpeed : float = 0
var doneBool : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bombTime.text = str(round(bombTimeInt))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	bombTime.text = str(int(bombTimeInt))
	if anim.speed_scale < animSpeed:
		anim.speed_scale = animSpeed
	
	if bombTimeInt > 0:
		bombTimeInt -= 1 * delta
		animSpeed += 0.01 * delta
	else:
		doneBool = true

	if bombTimeInt < 20:
		detonationText.modulate = Color(1, 0, 0, 1)
		bombTime.modulate = Color(1, 0, 0, 1)
