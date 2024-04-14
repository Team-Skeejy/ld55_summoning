extends Sprite2D

@onready var parent: UIButton = get_parent()

@export var up_sprite: Vector2i
@export var over_sprite: Vector2i
@export var down_sprite: Vector2i

func _process(_delta: float) -> void:
	if parent._absolute_down:
		frame_coords = down_sprite
	elif parent._entity_over || parent._mouse_over:
		frame_coords = over_sprite
	else:
		frame_coords = up_sprite