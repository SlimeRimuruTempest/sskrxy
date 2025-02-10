extends NodeSTG

@export var sl: Texture2D
@export var sm: Texture2D
@export var sr: Texture2D


func _physics_process(delta: float) -> void:
	super(delta)
	var dir: Vector2 = get_dir(ang)
	if dir.x < 0:
		sprite.texture = sl
	elif dir.x > 0:
		sprite.texture = sr
	else:
		sprite.texture = sm
