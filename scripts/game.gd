extends Node

@export var enemy_scenes: Array[PackedScene]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_enemy_timer_timeout() -> void:
	var enemy_scene = enemy_scenes.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = Vector2(187,150)
	add_child(enemy_instance)
	pass # Replace with function body.
