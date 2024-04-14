extends Node2D

class_name Dude

@export var health: int = 10;
@export var attack_power: int = 1;
@export var team: int = 1;
@export var speed: float = 0.1;
@export var attack_range: float = 1;
@export var attack_interval: float = 1;
@export var parentContainer: Node2D;
@export var home: Node2D;
@export var bad_home: Node2D;
@export var stateMachine: StateMachine;
@export var current_state: String = "";
@export var is_dead: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stateMachine.containerReference = parentContainer
	stateMachine.home = home
	stateMachine.bad_home = bad_home
	stateMachine.set_refs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if !is_dead:
		current_state = stateMachine.current_state.name
		check_aliveness()

func check_aliveness() -> void:
	if(health <= 0):
		is_dead = true;
		parentContainer.child_killed(team)
		queue_free()
		

var time_since_last_attack: float = 0
func attack(closest: Dude, delta: float) -> void:
	if(health <= 0):
		return
	time_since_last_attack += delta
	if(attack_interval > time_since_last_attack):
		time_since_last_attack = 0;
		if closest:
			var distance = distance_to(closest)
			if(distance < attack_range):
				closest.health = closest.health - attack_power


#Private equivs

func distance_to(target) -> float:
	if(target is Vector2):
		return get_global_transform().origin.distance_to(target)
	return get_global_transform().origin.distance_to(target.get_global_transform().origin)
