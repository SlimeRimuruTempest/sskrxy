extends Node2D

@export var game_len: float = 60

var nts: PackedScene = preload("res://Scene/StartScene/start_scene.tscn")

@onready var game_timer: Timer = $GameTimer

func _ready() -> void:
	game_timer.start(game_len)

func _on_game_timer_timeout() -> void:
	GlobalManager.game_mode = 1
	GlobalCanvasLayer.change_scene(nts)
