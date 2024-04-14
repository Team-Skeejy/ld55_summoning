extends State

class_name ReturnHome

@export var character: Dude
@export var home: Node2D

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func Update(delta) -> void:
	if home && character:
		var distance = distance_to(character, home)
		if distance > 10:
			move_to(character, home)
		else:
			Transitioned.emit(self, "idle")
