extends TextureProgressBar


func _on_player_health_updated(current_health: float, max_health: float) -> void:
	value = current_health / max_health
