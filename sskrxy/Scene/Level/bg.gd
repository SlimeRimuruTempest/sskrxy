extends Sprite2D


@export var update_time: Array[float]
@export var update_bg: Array[Texture2D]

var tot_time: float

func _physics_process(delta: float) -> void:
	if update_time.is_empty():
		return
	tot_time += delta
	if update_time[0] <= tot_time:
		update_time.pop_front()
		texture = update_bg.pop_front()
