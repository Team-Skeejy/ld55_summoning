extends State

class_name ReturnHome

@export var character: Dude
@export var home: Node2D
@export var containerReference: Node2D

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Update(delta) -> void:
	if get_closest_enemy(containerReference, character):
		Transitioned.emit(self, "attack")

	if home && character:
		var distance = distance_to(character, home)
		if distance > 10:
			move_to(character, home, delta)
		else:
			Transitioned.emit(self, "idle")
