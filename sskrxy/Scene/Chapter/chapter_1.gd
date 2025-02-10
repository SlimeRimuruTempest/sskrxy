extends Node2D

@onready var voice: AudioStreamPlayer = $Voice

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue_sprite: Sprite2D = $DialogueSprite
@onready var ego: PanelContainer = $Ego/Ego

var book_cnt: int = 0

@export var dialogue_tex: Array[Texture2D]
@export var dialogue_voice: Array[AudioStream]

var nts: PackedScene = preload("res://Res/Sample/sample.tscn")

func _ready() -> void:
	dialogue_sprite.modulate.a = 0

func talk():
	if dialogue_tex.is_empty():
		return
	var tween: Tween
	tween = create_tween()
	GlobalCanvasLayer.set_mouse_disabled(true)
	tween.tween_callback(func():
		dialogue_sprite.texture = dialogue_tex.pop_front()
		var stream: AudioStream = dialogue_voice.pop_front()
		voice.stream = stream
		voice.play()
	)
	tween.tween_property(dialogue_sprite, "modulate:a", 1, 0.3).from(0)
	await tween.finished
	await get_tree().create_timer(voice.stream.get_length(), false).timeout
	tween = create_tween()
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
	if not dialogue_voice.is_empty():
		voice.stream = dialogue_voice.pop_front()
		voice.play()
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
		await get_tree().create_timer(0.3, false).timeout
		GlobalCanvasLayer.change_scene(nts)
