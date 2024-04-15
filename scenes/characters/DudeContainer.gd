extends Node2D

class_name DudeContainer
var dude: PackedScene = load("res://scenes/characters/Dude.tscn")

signal dude_killed(team: int)
signal house_killed(team: int)

@export var good_home: Home
@export var bad_home: Home
@export var spawners: Array[Node2D]


func child_killed(team: int) -> void:
	dude_killed.emit(team)

func setup() -> void:
	for home: Home in [good_home, bad_home]:
		home.health = home.max_health
		home.is_dead = false

var spawner_index: int = 0;

func spawn_dude(is_player_team: bool, properties: Array[Property]) -> void:
	var new_dude: Dude = dude.instantiate()
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
		var index: int = spawners.size()
		spawner_index += 1

		new_dude.global_position = spawners[spawner_index % index].global_position

	if properties:
		for property: Property in properties:
			new_dude.constructed_with.push_back(property.name)

	if new_dude.get_parent():
		new_dude.reparent(self)
	else:
		add_child(new_dude)

	if properties:
		for property: Property in properties:
			new_dude.add_child(property)
			property.init(new_dude)


func _on_home_1_killed() -> void:
	house_killed.emit(0)


func _on_home_2_killed() -> void:
	house_killed.emit(1)
