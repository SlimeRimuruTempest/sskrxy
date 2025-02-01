extends NodeSTG
class_name Shooter

## 出生到启动的等待时间
@export var start_time: float

## 发射物
@export var bullet_ps: PackedScene = null

## 发射物曲线
@export var bullet_lin_curve: Curve = Curve.new()

@export var bullet_ang_curve: Curve = Curve.new()

## 发射位置在发射方向的偏移
@export var shoot_offset: float
## 发射时间间隔
@export var shoot_cd: float
## 发射数量
@export var shoot_num: float

func _on_ready() -> void:
	await get_tree().create_timer(start_time).timeout
	for i in shoot_num:
		var bullet: NodeSTG = bullet_ps.instantiate()
		marker.add_child(bullet)
		var pos_offset: Vector2 = dir * shoot_offset
		bullet.global_position = self.global_position + pos_offset
		bullet.ori_ang = ang
		bullet.lin_curve = bullet_lin_curve
		bullet.ang_curve = bullet_ang_curve
		if shoot_cd > 0.0:
			await get_tree().create_timer(shoot_cd).timeout
