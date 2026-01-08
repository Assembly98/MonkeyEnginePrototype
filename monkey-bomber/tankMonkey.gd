extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var chargeSfx = $chargeSfx
@onready var shotSfx = $shotSfx
@onready var timer = $Timer
@onready var blastSfx = $shotSfx
@onready var tankAnims = $tankAnims


@onready var main = get_tree().get_root().get_node("testLevel")
@onready var projectile = load("res://tankAmmo.tscn")

var rng = randi_range(1, 3)
var shootBool = false
var chargeCheck = 1
var projectilePos : Vector2
var turnCheck : int = 1

func _physics_process(delta: float) -> void:
	#collision_mask = rng
	
	#print(collision_layer)
	#print(collision_mask)
	#print(shootBool)
	#print(position)
	
	if rng != 3:
		collision_layer = rng
	else:
		collision_layer = 4
	
	if rng == 1 :
		position.y = move_toward(position.y, 43, 3)
		projectilePos = Vector2(global_position.x-75, 55)
	if rng == 2 :
		position.y = move_toward(position.y, 1, 3)
		projectilePos = Vector2(global_position.x-75, 10)
	if rng == 3 :
		collision_layer = 4
		position.y = move_toward(position.y, -42, 3)
		projectilePos = Vector2(global_position.x-75, -32)
		
		
	if round(timer.time_left) == 0:
		rng = randi_range(1, 3)
		timer.start()
	
	print("tCollisionLayer: ", collision_layer)
	print("rng: ", rng)
	if shootBool == true and chargeCheck > 0:
		chargeCheck -= 1
		anim.play("blinkIndicator")
		if not chargeSfx.is_playing():
			chargeSfx.play()
	
	
	#print(timer.time_left)
	
	move_and_slide()

func shoot():
	var instance = projectile.instantiate()
	instance.direction = rotation
	instance.spawnPos = projectilePos
	instance.spawnRot = rotation
	await(anim.animation_finished)
	shotSfx.play()
	main.add_child.call_deferred(instance)
