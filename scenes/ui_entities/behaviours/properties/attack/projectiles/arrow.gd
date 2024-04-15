class_name Arrow
extends Sprite2D

var target: Attackable
var attack_power: float = 0

var speed: float = 100

func _ready() -> void:
	print_debug("weow")

func _process(delta: float) -> void:
	if !is_instance_valid(self) || !is_instance_valid(target):
		queue_free()
		return

	if global_position.distance_to(target.global_position) < 1:
		target.health -= attack_power
		queue_free()
	else:
		look_at(target.global_position)
		global_position = global_position.move_toward(target.global_position, speed * delta)

