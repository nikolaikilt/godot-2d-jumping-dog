extends Node

@export var enemy_scenes: Array[PackedScene]

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/Score.add_theme_color_override("font_color","White")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_enemy_timer_timeout() -> void:
	
	var enemy_scene = enemy_scenes.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	if Global.counter:
		Global.prev_enemy_instance_name = Global.enemy_instance_name
	Global.enemy_instance_name = enemy_instance.name
	Global.counter = true
	if enemy_instance.name == "cratedouble" or enemy_instance.name == "cratedouble_carrot":
		enemy_instance.position = Vector2(187,120)
	else: 
		enemy_instance.position = Vector2(187,150)
	add_child(enemy_instance)
	pass # Replace with function body.


func _on_player_hit() -> void:
	$ScoreTimer.stop()
	$HUD/Score.hide()
	$"HUD/Final Message".show()
	$"HUD/Final score".text = str(score)
	$"HUD/Final score".show()
	$BackgroundMusic.pitch_scale = 0.4
	Engine.time_scale = 0.1
	await get_tree().create_timer( 3 *Engine.time_scale).timeout
	#ricarico la scena corrente
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	


func _on_score_timer_timeout() -> void:
	score +=1
	$HUD/Score.text = str(score)


func _on_speed_time_timeout() -> void:
	Engine.time_scale += 0.01
	

func _on_player_bonus() -> void:
	
	score +=10
	$HUD/Score.add_theme_color_override("font_color","Red")
	await get_tree().create_timer( 1 *Engine.time_scale).timeout
	
	$HUD/Score.add_theme_color_override("font_color","White")
