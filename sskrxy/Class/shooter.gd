extends NodeSTG
class_name Shooter

## 出生到显示的等待时间
@export var show_time: float
## 显示到启动的等待时间
@export var start_time: float
## 发射完到销毁的等待时间
@export var end_time: float

## 发射物
@export var bullet_ps: PackedScene = null

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

var started: bool = false

func shoot_once():
	for i in once_num:
		#var lin_off: = once_lin_curve.sample(i)
		var ang_off: = once_ang_curve.sample_baked(i)
		var bullet: NodeSTG = bullet_ps.instantiate()
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
	started = true
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

func _physics_process(delta: float) -> void:
	if visible == false:
		return
	if not started:
		return
	tot_time += delta
	global_position += get_movement(delta)

func _on_ready() -> void:
	hide()
	await get_tree().create_timer(show_time).timeout
	show()
	shoot()
