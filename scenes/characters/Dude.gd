extends Node2D

@export var health: int = 10;
@export var attack: int = 1;
@export var team: int = 1;
@export var speed: float = 0.1;
@export var attack_range: float = 1;
@export var parentContainer: Node2D;
@export var homeNode: Node2D;
@export var idle_time = 1;
@export var attack_interval = 0.5

var state = load("res://scenes/characters/State.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var children = parentContainer.get_children()
	var alive_enemies = children.filter(filter_enemy)
	var closest = get_closest(alive_enemies)
	check_aliveness()
	work_pathing(closest, delta)
	attack_locally(closest, delta)

func check_aliveness():
	if(health <= 0):
		queue_free()

var time_since_last_attack = 0
func attack_locally(closest, delta):
	time_since_last_attack += delta
	if(attack_interval > time_since_last_attack):
		time_since_last_attack = 0;
		if(closest):
			var distance = distance_to(closest)
			if(distance < attack_range):
				closest.health = closest.health - attack


func get_closest(enemies):
	var closest_distance = 99999
	var closest = null
	for dude in enemies:
		var distance = distance_to(dude);
		if distance < closest_distance:
			closest_distance = distance
			closest = dude
	return closest

var idled_before_home_time = 0.0;
func work_pathing(closest, delta):
	if(closest):
		reset_idle()
		idled_before_home_time = 0;
		move_to(closest.global_position)
	else:
		if(homeNode && idled_before_home_time > idle_time):
			if(distance_to(homeNode) < 5):
				be_idle(delta)
			else:
				reset_idle()
				move_to(homeNode.global_position)
		else:
			idled_before_home_time += delta
			be_idle(delta)
		pass
	pass

#Private equivs

func distance_to(target):
	if(target is Vector2):
		return get_global_transform().origin.distance_to(target)
	return get_global_transform().origin.distance_to(target.get_global_transform().origin)

func move_to(target):
	global_position += ((target - global_position).normalized() * speed)

func reset_idle():
	idle_target = null
	waited_time = 0

var idle_target = null
var waited_time = 0
func be_idle(delta):
	if(idle_target == null):
		var pos = get_global_transform().origin;
		idle_target = Vector2(pos.x + randf_range(-10, 10), pos.y + randf_range(-10, 10))
		#pick a new point and wait time
		pass
	if(distance_to(idle_target) > 1):
		move_to(idle_target)
	else:
		waited_time += delta
		if(waited_time > 1):
			reset_idle()

func filter_enemy(child):
	return child.team != team
