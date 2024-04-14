extends State

class_name Attack


@export var character: Dude
@export var containerReference: Node2D

var target: Dude = null


func Enter() -> void:
	target = get_closest_enemy(containerReference, character)
	
func Exit() -> void:
	target = null
	
func Update(delta: float) -> void:
	var running_target: Dude = get_target()
	if running_target != null:
		if character:
			character.attack(running_target, delta)
		move_to(running_target)
	else:
		Transitioned.emit(self, "idle")

func move_to(dest_target: Dude) -> void:
	if character:
		var direction: Vector2 =  dest_target.global_position - character.global_position
		direction = direction.normalized()
		character.global_position += direction * character.speed


func get_target() -> Dude:
	if target and target.health and target.health > 0:
		return target
	return get_closest_enemy(containerReference, character)
