extends Control

@export var nts: PackedScene

@onready var start_game: Sprite2D = $StartGame

var can_accept: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if can_accept:
			GlobalCanvasLayer.change_scene(nts)

func _ready() -> void:
	start_game.hide()
	await get_tree().create_timer(2.6).timeout
	start_game.show()
	var tween: Tween = start_game.create_tween().set_loops()
	tween.tween_property(start_game, "modulate:a", 1, 0.6).from(0.2)
	tween.tween_property(start_game, "modulate:a", 0.2, 0.6).from(1)
	await get_tree().create_timer(0.5).timeout
	can_accept = true

func _on_start_button_pressed() -> void:
	if can_accept:
		GlobalCanvasLayer.change_scene(nts)
