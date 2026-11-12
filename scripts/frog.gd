extends CharacterBody2D

func _physics_process(delta: float) -> void:
	velocity.x =  - Global.scroll_speed
	
	move_and_slide()
