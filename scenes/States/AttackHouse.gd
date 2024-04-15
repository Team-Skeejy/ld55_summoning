extends State

class_name AttackHouse

@export var character: Dude
@export var containerReference: Node2D
@export var target_base: Node2D

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Update(delta: float) -> void:
	if is_other_enemy():
		Transitioned.emit(self, "attack")
		return
	
	move_to(character, target_base)
	var distance = distance_to(character, target_base)
	if distance < character.attack_range:
		pass
		character.attack(target_base, delta)

func is_other_enemy():
	var closest = get_closest_enemy(containerReference, character)
	return !!closest
