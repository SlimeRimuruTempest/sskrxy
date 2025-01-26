extends NodeSTG
class_name Shooter

## 发射物
@export var bullet_ps: PackedScene = null
## 发射物寿命
@export var bullet_lifetime: float = 6.0
## 发射物速度
@export var bullet_speed: float = 100.0
## 枪口初始角度
@export_range(0.0, 360) var bullet_rot_start: float
## 每发射一次，枪口旋转多少度
@export_range(0.0, 360) var bullet_rot_offset: float
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
		bullet.speed = bullet_speed
		bullet.rot_angle = bullet_rot_start + i * bullet_rot_offset
		bullet.lifetime = bullet_lifetime
		if shoot_cd > 0.0:
			await get_tree().create_timer(shoot_cd).timeout
