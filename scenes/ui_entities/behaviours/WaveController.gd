extends Node2D

class_name WaveController

@export var dude_container: DudeContainer
@export var mook_interval: float = 5
@export var boss_interval: float = 60
@export var wave_timer_reduction: float = 0.0

signal boss_spawn()
signal enemy_spawn()

func _ready() -> void:
	pass

var mook_timer: float = 0
var boss_timer: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mook_timer += delta
	boss_timer += delta

	if mook_timer > mook_interval:
		mook_timer = 0
		mook_interval = (1 - wave_timer_reduction) * mook_interval  
		spawn_mook()

	if boss_timer > boss_interval:
		boss_timer = 0
		boss_timer = (1 - wave_timer_reduction) * boss_timer
		spawn_boss()

func spawn_mook() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("knife")
	]
	dude_container.spawn_dude(false, options)
	enemy_spawn.emit()

func spawn_boss() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("bow")
	]
	dude_container.spawn_dude(false, options)
	boss_spawn.emit()
	
