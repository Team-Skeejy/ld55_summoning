extends Node2D
class_name Game

@export var interval_spawn_rate: float = 10
@export var test_entity: PackedScene
@export var ui: UI
@export var dude_container: DudeContainer

func _ready() -> void:
	#spawn five at the start of the round so we can get started
	for i: int in [1,2,3,4,5]:
		spawn_entity()

	dude_container.spawn_dude(true, [])
	dude_container.spawn_dude(false, [])


func _process(_delta: float) -> void:
	pass


func spawn_entity() -> void:
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	ui.inventory.add_entity(entity)


func _on_ui_summon(properties: Array[Property]) -> void:
	dude_container.spawn_dude(true, properties)


func _on_dude_container_dude_killed(_team: int) -> void:
	spawn_entity()
