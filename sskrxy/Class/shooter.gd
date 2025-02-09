extends NodeSTG
class_name Shooter

## 出生到显示的等待时间
@export var show_time: float
## 显示到启动的等待时间
@export var start_time: float
## 发射完到销毁的等待时间
@export var end_time: float

## 发射物
@export var bullet_pool: Array[PackedScene]

enum ShootMode1 { PICK_SEQUENCE, PICK_RANDOM }
enum ShootMode2 { EVERY_MOMENT, EVERY_BULLET }

## 从子弹池顺序抽取还是随机抽取
@export var shoot_mode_1: ShootMode1
## 抽取是对于每轮齐射还是每颗子弹
@export var shoot_mode_2: ShootMode2

## 发射物速率曲线
@export var bullet_lin_curve: Curve = Curve.new()
## 发射物角度曲线
@export var bullet_ang_curve: Curve = Curve.new()

## 单次发射个数
@export var once_num: int = 1
# 同时发射时每个子弹速率偏移曲线 x为第几发 x范围必须是[0,once_num) y为那一发相对原速率的偏移速率
#@export var once_lin_curve: Curve = Curve.new()
## 同时发射时每个子弹角度偏移曲线 x为第几发 x范围必须是[0,once_num) y为那一发相对原角度的偏移角度
@export var once_ang_curve: Curve = Curve.new()

## 发射位置在发射方向的偏移
@export var shoot_pos_offset: float
## 发射时间间隔
@export var shoot_cd: float
## 发射次数
@export var shoot_num: int

## 是否跟随老妈
@export var bullet_follow_mum: bool = false

var pool_id: int = 0:
	set(v):
		pool_id = v % bullet_pool.size()

func get_bullet() -> PackedScene:
	var bullet_ps: PackedScene = null
	match shoot_mode_1:
		ShootMode1.PICK_SEQUENCE:
			bullet_ps = bullet_pool[pool_id]
			pool_id += 1
		ShootMode1.PICK_RANDOM:
			bullet_ps = bullet_pool.pick_random()
	return bullet_ps

func shoot_once():
	var bullet_ps: PackedScene = null
	for i in once_num:
		match shoot_mode_2:
			ShootMode2.EVERY_MOMENT:
				if bullet_ps == null:
					bullet_ps = get_bullet()
			ShootMode2.EVERY_BULLET:
				bullet_ps = get_bullet()
		#var lin_off: = once_lin_curve.sample(i)
		var bullet: = bullet_ps.instantiate()
		var ang_off: = once_ang_curve.sample(i)
		if bullet_follow_mum:
			add_child(bullet)
		else:
			marker.add_child(bullet)
		var pos_offset: Vector2 = get_dir(ang + ang_off) * shoot_pos_offset
		bullet.global_position = self.global_position + pos_offset
		bullet.ori_ang = ang + ang_off
		bullet.lin_curve = bullet_lin_curve
		bullet.ang_curve = bullet_ang_curve

func shoot():
	await get_tree().create_timer(start_time).timeout
	for i in shoot_num:
		await shoot_once()
		if shoot_cd > 0.0:
			await get_tree().create_timer(shoot_cd).timeout
	await get_tree().create_timer(end_time).timeout
	delete()

func delete():
	for child in get_children():
		if child is NodeSTG:
			child.reparent(marker)
	super()

func _on_ready() -> void:
	hide()
	await get_tree().create_timer(show_time).timeout
	show()
	shoot()
