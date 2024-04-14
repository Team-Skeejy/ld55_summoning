class_name Arrow
extends Sprite2D

var target: Dude
var attack_power: float = 0

var speed: float = 10

func _process(delta: float) -> void:
	if global_position.distance_to(target.global_position) < 1:
		target.health -= attack_power
		queue_free()
	else:
		look_at(target.global_position)
		global_position = global_position.move_toward(target.global_position, speed * delta)

