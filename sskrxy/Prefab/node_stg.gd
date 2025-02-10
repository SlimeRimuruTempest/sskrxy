extends Node2D
class_name NodeSTG

@onready var marker: = get_tree().get_first_node_in_group("Marker")
@onready var sprite: Sprite2D = $Sprite

## 素材的旋转偏移
@export var sprite_rot_off: float = 0.0
## 是否锁住sprite旋转
@export var lock_rot: bool = false

## 以多少度角为0度角
@export var ori_ang: float
## 速率曲线
@export var lin_curve: Curve = Curve.new()
## 角度曲线
@export var ang_curve: Curve = Curve.new()

var tot_time: float = 0

var lin: float:
	get:
		return lin_curve.sample(tot_time)
var ang: float:
	get:
		return ang_curve.sample(tot_time) + ori_ang

var mum_ang_off: float = 0.0

func get_dir(a: float):
	return Vector2.from_angle(deg_to_rad(a))
func get_movement(delta: float):
	return get_dir(ang) * lin * delta

func _process(delta: float) -> void:
	if not lock_rot:
		sprite.global_rotation_degrees = ang + sprite_rot_off
	else:
		sprite.global_rotation_degrees = sprite_rot_off

func _physics_process(delta: float) -> void:
	if visible == false:
		return
	tot_time += delta
	global_position += get_movement(delta)
	global_rotation_degrees = ang

func delete():
	queue_free()
