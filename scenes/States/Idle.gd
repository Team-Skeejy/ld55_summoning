extends State

class_name Idle

@export var character: Dude
@export var containerReference: Node2D

var idle_target = null
var wander_time: float = 0

func Enter() -> void:
	reset_wander_target()
	
func Exit() -> void:
	reset_wander_target()
	
func Update(delta) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		reset_wander_target()

	if character:
		character.global_position += idle_target * character.speed

	check_enemies()


func reset_wander_target():
	idle_target = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1,3)

func check_enemies():
	if containerReference:
		var children = containerReference.get_children()
		var alive_enemies = children.filter(func (child): return child.team != character.team)
		var closest = get_closest(alive_enemies)
		if closest:
			Transitioned.emit(self, "attack")

func distance_to(target):
	if(target is Vector2):
		return character.get_global_transform().origin.distance_to(target)
	return character.get_global_transform().origin.distance_to(target.get_global_transform().origin)


func get_closest(enemies):
	var closest_distance = 99999
	var closest = null
	for dude in enemies:
		var distance = distance_to(dude);
		if distance < closest_distance:
			closest_distance = distance
			closest = dude
	return closest
