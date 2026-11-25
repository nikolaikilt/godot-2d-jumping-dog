extends CharacterBody2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.x =  - Global.scroll_speed 
		velocity.y = velocity.y * Engine.time_scale
		velocity += get_gravity()*0.01 * delta
		
	move_and_slide()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
