extends NodeSTG
class_name Shooter

## 出生到启动的等待时间
@export var start_time: float
## 发射物
@export var bullet_ps: PackedScene = null

## 发射物曲线
@export var bullet_lin_curve: Curve
@export var bullet_ang_curve: Curve

## 发射时间间隔
@export var shoot_cd: float
## 发射数量
@export var shoot_num: float

func _on_ready() -> void:
	await get_tree().create_timer(start_time).timeout
	for i in shoot_num:
		var bullet: NodeSTG = bullet_ps.instantiate()
		marker.add_child(bullet)
		bullet.global_position = self.global_position
		bullet.lin_curve = bullet_lin_curve
		bullet.ang_curve = bullet_ang_curve
		if shoot_cd > 0.0:
			await get_tree().create_timer(shoot_cd).timeout
