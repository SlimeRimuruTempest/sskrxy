extends Node

signal time_scale_changed

var time_scale: float = 1.0

var game_mode: int = 0

func set_time_scale(value: float):
	time_scale = max(0.2, value)
	time_scale_changed.emit()
	AudioServer.playback_speed_scale = time_scale
	Engine.time_scale = time_scale

func _unhandled_input(event: InputEvent) -> void:
	#return
	if event.is_action_pressed("speed_up"):
		set_time_scale(time_scale+0.2)
	if event.is_action_pressed("speed_down"):
		set_time_scale(time_scale-0.2)
