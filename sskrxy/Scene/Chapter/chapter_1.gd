extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue_sprite: Sprite2D = $DialogueSprite
@onready var ego: PanelContainer = $Ego/Ego

var book_cnt: int = 0

@export var dialogue_tex: Array[Texture2D]
@export var nts: PackedScene

func _ready() -> void:
	dialogue_sprite.modulate.a = 0

func talk(time: = 2.0):
	var tween: Tween = create_tween()
	GlobalCanvasLayer.set_mouse_disabled(true)
	tween.tween_callback(func():
		if not dialogue_tex.is_empty():
			dialogue_sprite.texture = dialogue_tex.pop_front()
	)
	tween.tween_property(dialogue_sprite, "modulate:a", 1, 0.3).from(0)
	tween.tween_interval(time)
	tween.tween_property(dialogue_sprite, "modulate:a", 0, 0.3).from(1)
	await tween.finished
	GlobalCanvasLayer.set_mouse_disabled(false)


func on_book_pressed():
	book_cnt += 1

func on_book_closed():
	talk()

func _on_p_1_button_down() -> void:
	if book_cnt < 9:
		return
	book_cnt += 1
	ego.show()
	var tween: Tween = create_tween()
	tween.tween_property(ego, "modulate:a", 1, 0.6).from(0)

func _on_p_1_mouse_entered() -> void:
	if book_cnt >= 9:
		return
	animation_player.play("show9")

func _on_p_1_mouse_exited() -> void:
	animation_player.play_backwards("show9")

func _on_ego_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		#var tween: Tween = create_tween()
		#tween.tween_property(ego, "modulate:a", 0, 0.6).from(1)
		#await tween.finished
		#ego.hide()
		await get_tree().create_timer(0.3).timeout
		GlobalCanvasLayer.change_scene(nts)
