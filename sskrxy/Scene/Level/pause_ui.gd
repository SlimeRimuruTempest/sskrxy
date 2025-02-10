extends Control

@onready var pause_sfx: AudioStreamPlayer = $PauseSFX

func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			game_continue()
		else:
			game_pause()

func game_pause():
	pause_sfx.play(0.26)
	show()
	get_tree().paused = true

func game_continue():
	hide()
	get_tree().paused = false

func _on_restart_button_pressed() -> void:
	GlobalCanvasLayer.reload_current_scene()

func _on_continue_button_pressed() -> void:
	game_continue()
