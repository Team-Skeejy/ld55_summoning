extends Node2D

@export var interval_spawn_rate: float = 10
@export var test_entity: PackedScene
@export var ui: UI
@export var container: DudeContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

var spawn_timer:float = 0
func _process(delta: float) -> void:
	spawn_timer += delta
	if(spawn_timer > interval_spawn_rate):
		spawn_timer = 0
		spawn_entity()


func spawn_entity():
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	ui.inventory.add_entity(entity)


func _on_ui_summon() -> void:
	container.spawn_dude(1)


func _on_dude_container_dude_killed(team: int) -> void:
	spawn_entity()
