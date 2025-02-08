extends NodeSTG
class_name Bullet

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var damage: int = 1
@export var sprite_rot_off: float = 0.0

func _physics_process(delta: float) -> void:
	super(delta)
	sprite_2d.rotation_degrees = ang + sprite_rot_off


func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		body.get_damage(damage)
		queue_free()
