extends Node2D

class_name WaveController

@export var dude_container: DudeContainer
@export var mook_interval: float = 5
@export var boss_interval: float = 60


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
		spawn_mook()

	if boss_timer > boss_interval:
		boss_timer = 0
		spawn_boss()

func spawn_mook() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("knife")
	]
	dude_container.spawn_dude(false, options)

func spawn_boss() -> void:
	var options: Array[Property] = [
		PropertyFactory.entity_by_name("bow")
	]
	dude_container.spawn_dude(false, options)
