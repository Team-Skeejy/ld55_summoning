extends State

class_name Attack


@export var character: Dude
@export var containerReference: Node2D

var target = null


func Enter() -> void:
	print("attack now")
	target = get_closest_dude()
	
func Exit() -> void:
	target = null
	
func Update(delta: float) -> void:
	var running_target: Dude = get_target()
	if running_target != null:
		if character:
			character.attack(running_target, delta)
		move_to(running_target)
	else:
		print("idle now")
		Transitioned.emit(self, "idle")

func move_to(dest_target: Dude) -> void:
	if character:
		var direction: Vector2 =  dest_target.global_position - character.global_position
		direction = direction.normalized()
		character.global_position += direction * character.speed


func get_target() -> Dude:
	if target != null:
		return target
	return get_closest_dude()


func distance_to(target):
	if(target is Vector2):
		return character.get_global_transform().origin.distance_to(target)
	return character.get_global_transform().origin.distance_to(target.get_global_transform().origin)

func get_closest_dude() ->  Dude:
	var children = containerReference.get_children()
	var alive_enemies: Array = children.filter(func (child): return child.team != character.team)
	var closest_distance: float = 1.79769e308
	var closest: Dude = null
	for dude: Dude in alive_enemies:
		var distance = distance_to(dude);
		if distance < closest_distance:
			closest_distance = distance
			closest = dude
	return closest
