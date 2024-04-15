extends Attackable

class_name Dude

signal on_attack(target: Attackable)

@export var priority: int = 0
@export var attack_power: float = 1;
@export var speed: float = 10;
@export var prevent_regular_attack: bool = false;
@export var attack_range: float = 1;
@export var attack_interval: float = 1;
@export var parentContainer: DudeContainer;
@export var home: Node2D;
@export var target_base: Node2D;
@export var stateMachine: StateMachine;
@export var current_state: String = "";
@export var constructed_with: String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stateMachine.containerReference = parentContainer
	stateMachine.home = home
	stateMachine.target_base = target_base
	stateMachine.set_refs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !is_dead:
		current_state = stateMachine.current_state.name
		check_aliveness()

func check_aliveness() -> void:
	if (health <= 0):
		is_dead = true;
		parentContainer.child_killed(team)
		queue_free()


var time_since_last_attack: float = 0
func attack(closest: Attackable, delta: float) -> void:
	if (health <= 0):
		return
	time_since_last_attack += delta
	if (attack_interval < time_since_last_attack):
		time_since_last_attack = 0;
		if closest:
			var distance: float = distance_to(closest.global_position)
			if (distance < attack_range):
				if !prevent_regular_attack:
					closest.health = closest.health - attack_power
				on_attack.emit(closest)


#Private equivs

func distance_to(target: Vector2) -> float:
	return global_position.distance_to(target)
