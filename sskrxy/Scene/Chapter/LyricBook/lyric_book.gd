extends Node2D


@onready var texture_button: TextureButton = $TextureButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel_container: PanelContainer = $CanvasLayer/PanelContainer


func _on_texture_button_pressed() -> void:
	animation_player.play("fade in")
	await animation_player.animation_finished
	panel_container.show()

func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		panel_container.hide()
