extends Node

class_name WaveController

@export var dude_container: DudeContainer
@export var mook_interval: float = 15
@export var boss_interval: float = 60

signal boss_spawn()
signal enemy_spawn()

func _ready() -> void:
	pass

var mook_level: int = 0
var mook_timer: float = 0
var mook_count: int = 1

var boss_timer: float = 0
var boss_level: int = 0
var boss_count: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mook_timer += delta
	boss_timer += delta

	if mook_timer > mook_interval:
		mook_timer = 0
		# mook_interval = mook_interval
		for i: int in range(mook_count + 1):
			spawn_mook()
		mook_level += 1

	if boss_timer > boss_interval:
		boss_timer = 0
		# boss_timer = boss_timer
		for i: int in range(boss_count):
			spawn_boss()


func spawn_mook() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("knife"),
		PropertyFactory.entity_by_name("meat"),
	]

	for i: int in range(randi_range(0, mook_level)):
		options.push_back(PropertyFactory.entity_by_name("meat"))

	if mook_level > 6:
		var roll: float = randf_range(0, 1)
		if roll < 0.2:
			options.push_back(PropertyFactory.entity_by_name("bow"))
		elif roll < 0.4:
			options.push_back(PropertyFactory.entity_by_name("sword"))
		elif roll < 0.6:
			options.push_back(PropertyFactory.entity_by_name("spear"))


	dude_container.spawn_dude(false, options)
	enemy_spawn.emit()

func spawn_boss() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("knife")
	]

	for item in range(boss_level):
		options.push_back(PropertyFactory.entity_by_name("boss"))

	dude_container.spawn_dude(false, options)
	boss_spawn.emit()
	if boss_level == boss_count:
		boss_level += 1
		boss_count = 1

	mook_count += 1

