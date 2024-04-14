extends State

class_name AttackHouse

@export var character: Dude
@export var containerReference: Node2D
@export var bad_home: Node2D

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Update(_delta: float) -> void:
	move_to(character, bad_home)
	var distance = distance_to(character, bad_home)
	if distance < 1:
		pass
		#Do this and make sure it attacks the house
		#bad_home.health -= 1
