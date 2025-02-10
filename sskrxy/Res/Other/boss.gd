extends Sprite2D

@export var sl: Texture2D
@export var sm: Texture2D
@export var sr: Texture2D
@export var wait_time: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start(wait_time)

func _on_timer_timeout() -> void:
	animation_player.play("move")
