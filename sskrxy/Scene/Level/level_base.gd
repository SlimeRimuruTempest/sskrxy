extends Node2D

@export var game_len: float = 60

@export_file("*tscn") var nts: String

@onready var game_timer: Timer = $GameTimer

func _ready() -> void:
	game_timer.start(game_len)

func _on_game_timer_timeout() -> void:
	GlobalManager.game_mode = 1
	GlobalCanvasLayer.change_scene_to_file(nts)
