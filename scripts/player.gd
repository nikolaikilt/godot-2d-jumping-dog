extends CharacterBody2D
const JUMP_VELOCITY = -300.0
signal hit
signal bonus
var fixed_x: float


func _ready() -> void:
	fixed_x = Global.global_position_player
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y >0:
			$AnimatedSprite2D.play("falling")
	else:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.speed_scale = Engine.time_scale
	# Handle jump.
	if Input.is_action_just_pressed("click") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	
	velocity.x = 0.0
	move_and_slide()
	
	# Blocca eventuali spostamenti orizzontali causati da collisioni o piattaforme.
	global_position.x = fixed_x
	$"../HUD/debug".text = str(Global.enemy_instance_name)
	$"../HUD/debug2".text = str(Global.prev_enemy_instance_name)
	$"../HUD/debug3".text = str(Global.counter)
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider is CharacterBody2D :
			hit.emit()
		if (collider is AnimatableBody2D
			and Global.prev_enemy_instance_name == "crate_carrot"
			or Global.prev_enemy_instance_name == "cratedouble_carrot" 
			and Global.enemy_instance_name != "cratedouble" 
			and Global.enemy_instance_name != "crate" ) :
			bonus.emit()
			





func _on_bonus() -> void:
	pass # Replace with function body.
