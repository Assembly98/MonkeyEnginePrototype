extends CharacterBody2D


@export var progressBar : ProgressBar
@export var bombHud : AnimatedSprite2D

@onready var anim = $AnimationPlayer
@onready var sprite = $Icon
@onready var  moveSfx = $AudioStreamPlayer
@onready var hitTimer = $hitTimer
@onready var monkeyAnims = $AnimatedSprite2D
@onready var  endTimer = $endTimer

var speed = 350
var lives = 5
var progressSpeed = 1
var explosionBool : bool = false
var hasCompleted : bool = false


func _physics_process(delta: float) -> void:
	
	if progressBar.value == progressBar.max_value:
		hasCompleted = true
		if not anim.is_playing():
			anim.play("Win")
		if not $"24_Finish!CpuFinish".is_playing():
			$"../../FloriaFieldsKirbyAirRidersOst".stop()
			$"24_Finish!CpuFinish".play()
		await (anim.animation_finished)
		visible = false
		get_tree().paused = true
	elif bombHud.doneBool == true:
		hasCompleted = true
		monkeyAnims.play("Hit")
		if not $"PizzaTowerOstYourFatAssSlowsYouDown(time'sUp)".is_playing():
			$"../../FloriaFieldsKirbyAirRidersOst".stop()
			$"PizzaTowerOstYourFatAssSlowsYouDown(time'sUp)".play()
		await (get_tree().create_timer(5).timeout)
		get_tree().paused = true
		
	var vInput = Input.get_axis("ui_up", "ui_down")
	var hInput = Input.get_axis("ui_left", "ui_right")
	
	if hasCompleted == false:
		if Input.is_action_just_pressed('ui_right'):
			anim.play("dashR")
			moveSfx.play()
		elif Input.is_action_just_pressed('ui_left'):
			anim.play("dashL")
			moveSfx.play()
		if Input.is_action_just_pressed('ui_up'):
			anim.play("dashUp")
			moveSfx.play()
		elif Input.is_action_just_pressed('ui_down'):
			anim.play("dashDown")
			moveSfx.play()
		
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
			position.x += move_toward(speed, 350, 50) * hInput
		elif Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
			position.y += move_toward(speed, 350, 50) * vInput
	
	#print(hitTimer.time_left)
	#print(progressSpeed)
	
	if hitTimer.time_left > 0:
		progressSpeed = 0.075
		monkeyAnims.position.y = 75
		monkeyAnims.speed_scale = 3.5
		monkeyAnims.play("Hit")
	else:
		progressSpeed = 1
		monkeyAnims.position.y = 125
		monkeyAnims.speed_scale = 5
		monkeyAnims.play("default")
	
	move_and_slide()


func _on_player_collsion_area_entered(area: Area2D) -> void:
	if area.name == "ammoCollsion":
		hitTimer.start()
		$Explosion4.play()
		area.get_parent().get_child(0).speed_scale = 10
		area.get_parent().get_child(0).play("explode")
		area.get_parent().speed = 0
		await (area.get_parent().get_child(0).animation_finished)
		area.get_parent().queue_free()
	if area.name == "bombCollsion":
		hitTimer.start()
		$Explosion4.play()
		#area.get_parent().speed = 0
		#await (area.get_parent().get_child(0).animation_finished)
		#area.get_parent().queue_free()
	else:
		if explosionBool == true:
			$Explosion4.play()
		if hasCompleted == true:
			area.get_tree().paused = true
