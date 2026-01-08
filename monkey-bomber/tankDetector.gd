extends Area2D

@export var tankMonkey : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("bCollisionLayer: ", collision_layer)
	pass


func _on_body_entered(body: Node2D) -> void:
	print("true")
	if body == tankMonkey:
		if (tankMonkey.tankAnims.current_animation == "intro"):
			tankMonkey.tankAnims.play("turn")
			await (tankMonkey.tankAnims.animation_finished)
			tankMonkey.turnCheck -= 1
		if tankMonkey.turnCheck == 0:
			tankMonkey.shootBool = true
			tankMonkey.timer.start()
			tankMonkey.chargeCheck += 1
			print("true")
			print(collision_layer)
			if tankMonkey.anim:
				tankMonkey.shoot()
		
	else:
		tankMonkey.shootBool = false
		tankMonkey.timer.stop()
		print("false")
		
