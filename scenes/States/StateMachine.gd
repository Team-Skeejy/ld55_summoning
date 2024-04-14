extends Node

class_name StateMachine

@export var initial_state: State
@export var containerReference: Node2D
@export var character: Dude
@export var home: Node2D

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
	print("becoming a " + new_state_name)

func set_refs() -> void:
	for index in states:
		var child: State = states[index] 
		if "character" in child:
			child.character = character
		if "containerReference" in child:
			child.containerReference = containerReference
		if "home" in child:
			child.home = home
