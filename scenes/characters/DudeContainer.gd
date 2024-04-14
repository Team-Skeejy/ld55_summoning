extends Node2D

class_name DudeContainer

var dude = load("res://scenes/characters/Dude.tscn")

signal dude_killed(team: int)

@export var good_home: Node2D
@export var bad_home: Node2D

@export var template_entity: Entity;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func child_killed(team: int):
	dude_killed.emit(team)

func spawn_dude(team: int):
	var new_dude: Dude = dude.instantiate()
		
	new_dude.parentContainer = self
	new_dude.team = team
	if(team == 1):
		new_dude.bad_home = bad_home 
		new_dude.home = good_home
		new_dude.global_position = good_home.global_position
	else:
		new_dude.bad_home = good_home
		new_dude.home = bad_home
		new_dude.global_position = bad_home.global_position
	add_child(new_dude)
