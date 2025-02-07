extends CharacterBody2D
class_name PlayerBody

@onready var player_sprite: Sprite2D = $PlayerSprite

@export var tex_l: Texture2D
@export var tex_m: Texture2D
@export var tex_r: Texture2D

signal health_updated(current_health: float, max_health: float)

@export var max_health: int = 5:
	set(v):
		max_health = v
		health_updated.emit(current_health, max_health)

var current_health: int:
	set(v):
		current_health = v
		health_updated.emit(current_health, max_health)

@export var speed = 300.0

func get_damage(value: int):
	current_health -= value

func _ready() -> void:
	current_health = max_health
	player_sprite.texture = tex_m

func _process(delta: float) -> void:
	var lr: float = Input.get_axis("move_left", "move_right")
	if lr == 0:
		player_sprite.texture = tex_m
	elif lr < 0:
		player_sprite.texture = tex_l
	elif lr > 0:
		player_sprite.texture = tex_r

func _physics_process(delta: float) -> void:
	var dir := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
		).normalized()
	if dir:
		velocity = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()
