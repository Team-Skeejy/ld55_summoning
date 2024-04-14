extends Node2D

class_name DudeFactory
var dude: PackedScene = load("res://scenes/characters/Dude.tscn")

signal dude_killed(team: int)

@export var good_home: Node2D
@export var bad_home: Node2D


func child_killed(team: int) -> void:
	dude_killed.emit(team)


func instantiate_dude() -> Dude:
	return dude.instantiate()


func spawn_constructed_dude(new_dude: Dude, is_player_team: bool) -> void:
	new_dude.parentContainer = self
	if is_player_team:
		new_dude.team = 0
		new_dude.bad_home = bad_home
		new_dude.home = good_home
		new_dude.global_position = good_home.global_position
	else:
		new_dude.team = 1
		new_dude.bad_home = good_home
		new_dude.home = bad_home
		new_dude.global_position = bad_home.global_position

	if new_dude.get_parent():
		new_dude.reparent(self)
	else:
		add_child(new_dude)


func spawn_dude(is_player_team: bool) -> void:
	spawn_constructed_dude(instantiate_dude(), is_player_team)