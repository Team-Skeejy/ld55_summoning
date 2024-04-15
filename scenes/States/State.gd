extends Node
class_name State

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(delta: float):
	pass

func get_closest_enemy(container: Node2D, character: Node2D) -> Dude:
	var children = container.get_children()
	var alive_enemies = children.filter(func(child): return is_other_team(child, character))
	var closest = get_closest(alive_enemies, character)
	return closest

func get_closest(enemies: Array, character: Node2D):
	var closest_distance = 99999
	var closest = null
	for dude in enemies:
		var distance = distance_to(character, dude);
		if distance < closest_distance:
			closest_distance = distance
			closest = dude
	return closest

func is_other_team(child: Node2D, character: Node2D):
	if child and child is Dude:
		return child.team != character.team
	else:
		return false

func distance_to(character, target):
	if (target is Vector2):
		return character.get_global_transform().origin.distance_to(target)
	return character.get_global_transform().origin.distance_to(target.get_global_transform().origin)


func move_to(character: Dude, dest_target: Node2D) -> void:
	if character:
		var direction: Vector2 = dest_target.global_position - character.global_position
		direction = direction.normalized()
		character.global_position += direction * character.speed
