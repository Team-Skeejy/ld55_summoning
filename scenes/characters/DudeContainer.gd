extends Node2D

class_name DudeContainer
var dude: PackedScene = load("res://scenes/characters/Dude.tscn")

signal dude_killed(team: int)
signal house_killed(team: int)

@export var good_home: Home
@export var bad_home: Home


func child_killed(team: int) -> void:
	dude_killed.emit(team)

func setup():
	for home: Home in [good_home, bad_home]:
		home.health = 100
		home.is_dead = false
		
func spawn_dude(is_player_team: bool, properties: Array[Property]) -> void:
	var new_dude: Dude = dude.instantiate()
	if properties:
		for property: Property in properties:
			property.reparent(new_dude)
			property.init(new_dude)

	new_dude.parentContainer = self
	if is_player_team:
		new_dude.team = 0
		new_dude.target_base = bad_home
		new_dude.home = good_home
		new_dude.global_position = good_home.global_position
	else:
		new_dude.team = 1
		new_dude.target_base = good_home
		new_dude.home = bad_home
		new_dude.global_position = bad_home.global_position

	if new_dude.get_parent():
		new_dude.reparent(self)
	else:
		add_child(new_dude)


func _on_home_1_killed() -> void:
	house_killed.emit(0)


func _on_home_2_killed() -> void:
	house_killed.emit(1)
