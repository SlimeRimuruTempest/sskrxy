extends Node2D


@onready var texture_button: TextureButton = $TextureButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $CanvasLayer/PanelContainer

@onready var click: AudioStreamPlayer = $Click
@onready var close: AudioStreamPlayer = $Close


signal book_pressed
signal book_closed

func _on_texture_button_pressed() -> void:
	GlobalCanvasLayer.set_mouse_disabled(true)
	animation_player.play("fade in")
	await animation_player.animation_finished
	panel_container.show()
	click.play()
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "modulate:a", 1, 0.15).from(0)
	book_pressed.emit()

func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		close.play()
		var tween: Tween = create_tween()
		tween.tween_property(panel_container, "modulate:a", 0, 0.15).from(1)
		await tween.finished
		panel_container.hide()
		book_closed.emit()
		queue_free()

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		close.play()
		var tween: Tween = create_tween()
		tween.tween_property(panel_container, "modulate:a", 0, 0.15).from(1)
		await tween.finished
		panel_container.hide()
		book_closed.emit()
		queue_free()
