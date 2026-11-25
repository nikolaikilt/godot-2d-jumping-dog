extends Area2D
@onready var pickup_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	global_position.x -= Global.scroll_speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.score += 100

		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property($HUD/Score, "modulate", Color.WHITE, 0.3)
		tween.tween_property($HUD/Score, "scale", Vector2.ONE, 0.3)

		pickup_sound.play()
		hide()
		await get_tree().create_timer( 0.8 *Engine.time_scale).timeout
		queue_free()
