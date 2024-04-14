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
			move_to(home)
		else:
			Transitioned.emit(self, "idle")

	
func move_to(dest_target: Node2D) -> void:
	if character:
		var direction: Vector2 =  dest_target.global_position - character.global_position
		direction = direction.normalized()
		character.global_position += direction * character.speed
