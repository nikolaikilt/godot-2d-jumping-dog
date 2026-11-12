extends AnimatableBody2D

func _physics_process(delta: float) -> void:
	global_position.x -= Global.scroll_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
