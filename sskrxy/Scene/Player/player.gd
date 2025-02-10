extends CharacterBody2D
class_name PlayerBody

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var point: Sprite2D = $Point
@onready var hit_sfx: AudioStreamPlayer = $HitSFX
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var wudi: bool = false

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
		current_health = clamp(v, 0, max_health)
		health_updated.emit(current_health, max_health)

@export var speed: = 600.0
@export var slow_speed: = 300.0

func get_speed():
	if Input.is_action_pressed("slow"):
		return slow_speed
	return speed

func get_damage(value: int):
	if wudi:
		return
	hit_sfx.play()
	animation_player.play("Hit")
	current_health -= value
	if current_health == 0:
		wudi = true
		await get_tree().create_timer(0.3).timeout
		GlobalCanvasLayer.reload_current_scene()
	else:
		wudi = true
		await animation_player.animation_finished
		wudi = false

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
		velocity = dir * get_speed()
	else:
		velocity.x = move_toward(velocity.x, 0, get_speed())
		velocity.y = move_toward(velocity.y, 0, get_speed())
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("slow"):
		point.show()
	if event.is_action_released("slow"):
		point.hide()
