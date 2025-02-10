extends Node

@onready var bg_rect: ColorRect = $"CanvasLayer-1/BGRect"
@onready var front_color_rect: ColorRect = $CanvasLayer10/FrontColorRect
@onready var mouse_disabled: ColorRect = $CanvasLayer10/MouseDisabled

@onready var click_sfx_root: Node = $ClickSFXRoot

func _ready() -> void:
	front_color_rect.hide()
	front_color_rect.modulate.a = 0.0
	set_mouse_disabled(false)

func change_scene(p: PackedScene):
	front_color_rect.show()
	var tween: = create_tween()
	tween.tween_property(front_color_rect, "modulate:a", 1, 0.5).from(0)
	await tween.finished
	get_tree().change_scene_to_packed(p)
	await get_tree().tree_changed
	tween = create_tween()
	tween.tween_property(front_color_rect, "modulate:a", 0, 0.5).from(1)
	await tween.finished
	front_color_rect.hide()

func reload_current_scene():
	front_color_rect.show()
	var tween: = create_tween()
	tween.tween_property(front_color_rect, "modulate:a", 1, 0.5).from(0)
	await tween.finished
	get_tree().reload_current_scene()
	await get_tree().tree_changed
	tween = create_tween()
	tween.tween_property(front_color_rect, "modulate:a", 0, 0.5).from(1)
	await tween.finished
	front_color_rect.hide()

func set_mouse_disabled(v: bool):
	mouse_disabled.visible = v


func _on_bg_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		var click_sfx: AudioStreamPlayer = click_sfx_root.get_children().pick_random()
		click_sfx.play()

func _on_mouse_disabled_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		var click_sfx: AudioStreamPlayer = click_sfx_root.get_children().pick_random()
		click_sfx.play()
