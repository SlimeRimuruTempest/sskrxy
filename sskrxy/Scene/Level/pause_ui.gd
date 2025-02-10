extends Control

@onready var blur: ColorRect = $Blur

@onready var pause_sfx: AudioStreamPlayer = $PauseSFX

@onready var pause_sprite: TextureRect = $PauseSprite
@onready var game_over_sprite: TextureRect = $GameOverSprite

func _ready() -> void:
	pause_sprite.hide()
	game_over_sprite.hide()
	blur.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			game_continue()
		else:
			game_pause()

func game_over():
	blur.show()
	game_over_sprite.show()
	get_tree().paused = true

func game_pause():
	pause_sfx.play(0.26)
	blur.show()
	pause_sprite.show()
	get_tree().paused = true

func game_continue():
	pause_sprite.hide()
	blur.hide()
	get_tree().paused = false

func _on_restart_button_pressed() -> void:
	GlobalCanvasLayer.reload_current_scene()

func _on_continue_button_pressed() -> void:
	game_continue()

func _on_player_game_over() -> void:
	game_over()
