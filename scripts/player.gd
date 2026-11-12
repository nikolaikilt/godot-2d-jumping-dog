extends CharacterBody2D
const JUMP_VELOCITY = -300.0
signal hit
var fixed_x: float

func _ready() -> void:
	fixed_x = Global.global_position_player
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		$AnimatedSprite2D.play("run")
		
	# Handle jump.
	if Input.is_action_just_pressed("click") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	
	velocity.x = 0.0
	move_and_slide()
	# Blocca eventuali spostamenti orizzontali causati da collisioni o piattaforme.
	global_position.x = fixed_x
	
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider is CharacterBody2D and collider.name == "Frog":
			hit.emit()
