extends TextureProgressBar

@export var animation_player: AnimationPlayer

func _on_player_health_updated(current_health: float, max_health: float) -> void:
	value = current_health / max_health
	animation_player.play("blink")
