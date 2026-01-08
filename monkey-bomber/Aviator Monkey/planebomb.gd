extends CharacterBody2D
class_name planeBomb

@export var gridCollision : Node2D
@export var player : CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var timer = $Timer
@onready var bombCollision = $bombCollsion
@onready var chargeSfx = $chargeSfx
@onready var explosionSfx = $explosionSfx

@onready var newPlaneBomb = load("res://Aviator Monkey/planebomb.tscn")
@onready var  main = get_tree().get_root().get_node("grid")

var lastPos : Vector2
var ObjectCounter : int


func _physics_process(delta: float) -> void:
	#print(get_parent().get_children())
	print("timer: ", round(timer.time_left))
	
	if round(timer.time_left)/10.0 == 1.5 and ObjectCounter < 4:
		var planebomb = newPlaneBomb.instantiate()
		print("none")
		ObjectCounter += 1
		planebomb.player = player
		main.get_tree().get_root().add_child.call_deferred(planebomb)
	
	if timer.time_left > 0:
		lastPos = player.position
	else:
		lastPos = lastPos
	
	if timer.time_left == 0:
		position = lastPos
		visible = true
		if anim.name != "explosion":
			if not chargeSfx.is_playing():
				chargeSfx.play()
			anim.play("target")
		await (anim.animation_finished)
		bombCollision.monitoring = true
		bombCollision.monitorable = true
		chargeSfx.stop()
		if anim.animation_finished:
			anim.play("explosion", 3.5)
		if not explosionSfx.is_playing() and anim.name == "explosion":
			explosionSfx.play()
			player.explosionBool = true
		if explosionSfx.finished and anim.animation_finished:
			timer.start()
			player.explosionBool = false
	elif round(timer.time_left) > 0:
		chargeSfx.stop()
		visible = false
		#anim.play("target")
		bombCollision.monitoring = false
		bombCollision.monitorable = false
	move_and_slide()
