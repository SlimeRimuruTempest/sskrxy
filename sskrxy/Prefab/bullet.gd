extends NodeSTG
class_name Bullet

@export var damage: int = 1
@export var disposable: bool = true

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		body.get_damage(damage)
		if disposable:
			queue_free()
