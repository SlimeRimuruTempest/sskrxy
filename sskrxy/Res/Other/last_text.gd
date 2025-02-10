extends Sprite2D

@export var show_at: float = 10
@export var show_cost: float = 1

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start(show_at)
	modulate.a = 0

func _on_timer_timeout() -> void:
	var tween: = create_tween()
	tween.tween_property(self, "modulate", 1, show_cost).from(0)
