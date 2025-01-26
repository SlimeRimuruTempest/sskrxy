extends CharacterBody2D

@export var max_health: int
var current_health: int

const SPEED = 300.0

func get_damage(value: int):
	current_health -= value

func _ready() -> void:
	current_health = max_health

func _physics_process(delta: float) -> void:
	var dir := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
		).normalized()
	if dir:
		velocity = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
