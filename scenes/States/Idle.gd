extends State

class_name Idle

@export var character: Dude
@export var containerReference: Node2D

var idle_target = null
var wander_time: float = 0
var pause_time: float = 0
var total_idle_time: float = 0

func Enter() -> void:
	wander_time = randf_range(0,1)
	pause_time = wander_time
	
func Exit() -> void:
	total_idle_time = 0
	reset_wander_target()
	
func Update(delta) -> void:
	total_idle_time += delta
	if total_idle_time > 5:
		Transitioned.emit(self, "returnhome")

	if wander_time > 0:
		wander_time -= delta
		if character and wander_time > pause_time:
			character.global_position += idle_target * (character.speed * 0.5)
	else:
		reset_wander_target()
	check_enemies()


func reset_wander_target():
	idle_target = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1,5)
	pause_time = randf_range(wander_time * 0.8,wander_time)

func check_enemies():
	if containerReference:
		var closest = get_closest_enemy(containerReference, character)
		if closest:
			Transitioned.emit(self, "attack")
