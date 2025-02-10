extends Node2D

func _physics_process(delta: float) -> void:
	if (global_position - Vector2(960, 540)).length() >= 1000:
		get_parent().delete()
