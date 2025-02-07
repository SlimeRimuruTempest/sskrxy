extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var mouse_disabled: ColorRect = $MouseDisabled

func _ready() -> void:
	color_rect.hide()
	color_rect.modulate.a = 0.0
	set_mouse_disabled(false)

func change_scene(p: PackedScene):
	color_rect.show()
	var tween: = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1, 0.5).from(0)
	tween.tween_callback(func():
		get_tree().change_scene_to_packed(p)
		)
	tween.tween_property(color_rect, "modulate:a", 0, 0.5).from(1)
	await tween.finished
	color_rect.hide()

func reload_current_scene():
	color_rect.show()
	var tween: = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1, 0.5).from(0)
	tween.tween_callback(func():
		get_tree().reload_current_scene()
		)
	tween.tween_property(color_rect, "modulate:a", 0, 0.5).from(1)
	await tween.finished
	color_rect.hide()

func set_mouse_disabled(v: bool):
	mouse_disabled.visible = v
