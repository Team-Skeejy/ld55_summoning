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
@export var constructed_with: Array[String] = [];

@export var sprite: AnimatedSprite2D

var previous_position: Vector2
var current_speed: float
var base_animation: String

var direction: float = 1

const animations: Dictionary = {
	"": "",
	"sword": "_blade",
	"staff": "_staff",
	"spear": "_blade",
	"knife": "_blade",
	"bow": "_bow",
	"book": "_book",
	"bomb": "_bomb"
}


var is_attacking: bool = false

func handle_animation(anim_name: String) -> void:
	pass
# 	match anim_name:
# 		"attack", "attackhouse":
# 			is_attacking = true
# 			sprite.play(base_animation + "_atk", attack_interval / 5)
# 		_:
# 			is_attacking = false
# 			sprite.play(base_animation)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stateMachine.containerReference = parentContainer
	stateMachine.home = home
	stateMachine.target_base = target_base
	stateMachine.set_refs()

	stateMachine.state_transition.connect(handle_animation)


	var count: Dictionary = {}
	for value: String in constructed_with:
		if count.has(value):
			count[value] += 1
		else:
			count[value] = 1

	var most: int = 0
	var most_key: String = ""

	for key: String in count.keys():
		if count[key] > most:
			most = count[key]
			most_key = key

	if team == 0:
		base_animation += "ally"
	else:
		base_animation += "enemy"

	base_animation += animations[most_key.to_lower()]
	sprite.play(base_animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_dead:
		current_state = stateMachine.current_state.name
		check_aliveness()

	if global_position.x < previous_position.x:
		direction = -1
	else:
		direction = 1
	sprite.scale.x = direction

	current_speed = global_position.distance_to(previous_position) / delta
	previous_position = global_position

	if current_speed && is_attacking:
		is_attacking = false
		print("walk")
		sprite.play(base_animation)

	if !is_attacking:
		sprite.speed_scale = current_speed / 10

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

				is_attacking = true
				sprite.play(base_animation + "_atk", 1)
				sprite.speed_scale = 1 / attack_interval

				if !prevent_regular_attack:
					closest.health = closest.health - attack_power
				on_attack.emit(closest)
			else:
				if is_attacking:
					is_attacking = false
					sprite.play(base_animation)



#Private equivs

func distance_to(target: Vector2) -> float:
	return global_position.distance_to(target)
