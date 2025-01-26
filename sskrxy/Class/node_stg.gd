extends Node2D
class_name NodeSTG

@onready var marker: = get_tree().get_first_node_in_group("Marker")

## 出生到启动的等待时间
@export var start_time: float

@export var speed: float
@export var rot_angle: float
#@export var acc_time: float
#var acc: float

## 寿命，结束后消失，等于0.0就是离开屏幕消失
@export var lifetime: float = 6.0

## 自己消失后顶替自己的节点
@export var next_nodestg: PackedScene = null

func _physics_process(delta: float) -> void:
	var dir: Vector2 = Vector2.from_angle(deg_to_rad(rot_angle))
	# TODO 加速度
	global_position += dir * speed * delta

func delete():
	if next_nodestg != null:
		var nt: NodeSTG = next_nodestg.instantiate()
		marker.add_child(nt)
		nt.global_position = self.global_position
	queue_free()

func _ready() -> void:
	#acc = speed / acc_time
	if lifetime > 0.0:
		await get_tree().create_timer(lifetime+start_time).timeout
		delete()
