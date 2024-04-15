extends State

class_name AttackHouse

@export var character: Dude
@export var containerReference: Node2D
@export var target_base: Attackable

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
		character.attack(target_base, delta)
		
	if target_base.is_dead:
		Transitioned.emit(self, "returnhome")

func is_other_enemy():
	var closest = get_closest_enemy(containerReference, character)
	return !!closest
