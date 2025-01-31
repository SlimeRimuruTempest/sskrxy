extends Node2D
class_name NodeSTG

@onready var marker: = get_tree().get_first_node_in_group("Marker")

@export var lin_curve: Curve
@export var ang_curve: Curve

## 自己消失后顶替自己的节点
@export var next_nodestg: PackedScene = null

var tot_time: float = 0

func _physics_process(delta: float) -> void:
	tot_time += delta
	var lin: float = lin_curve.sample(tot_time)
	var ang: float = ang_curve.sample(tot_time)
	var dir: Vector2 = Vector2.from_angle(deg_to_rad(ang))
	global_position += dir * lin * delta

func delete():
	if next_nodestg != null:
		var nt: NodeSTG = next_nodestg.instantiate()
		marker.add_child(nt)
		nt.global_position = self.global_position
	queue_free()

func _ready() -> void:
	pass
