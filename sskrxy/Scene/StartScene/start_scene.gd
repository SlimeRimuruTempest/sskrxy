extends Control

@export_file("*tscn") var nts: String

@onready var start_game: Sprite2D = $StartGame
@onready var start_sfx: AudioStreamPlayer = $StartSFX
@onready var thank_rect: TextureRect = $ThankRect

var can_accept: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		if can_accept:
			can_accept = false
			GlobalCanvasLayer.change_scene_to_file(nts)

func _ready() -> void:
	if GlobalManager.game_mode == 1:
		thank_rect.show()
	else:
		thank_rect.hide()
	start_game.hide()
	await get_tree().create_timer(2.6, false).timeout
	start_game.show()
	var tween: Tween = start_game.create_tween().set_loops()
	tween.tween_property(start_game, "modulate:a", 1, 0.6).from(0.2)
	tween.tween_property(start_game, "modulate:a", 0.2, 0.6).from(1)
	await get_tree().create_timer(0.5, false).timeout
	can_accept = true

func _on_start_button_pressed() -> void:
	if can_accept:
		can_accept = false
		start_sfx.play()
		await get_tree().create_timer(1.0, false).timeout
		GlobalCanvasLayer.change_scene_to_file(nts)


func _on_thank_button_pressed() -> void:
	thank_rect.hide()
