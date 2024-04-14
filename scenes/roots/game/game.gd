extends Node2D
class_name Game

@export var interval_spawn_rate: float = 10
@export var test_entity: PackedScene
@export var ui: UI
@export var dude_factory: DudeFactory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

func _process(_delta: float) -> void:
	pass


func spawn_entity() -> void:
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	ui.inventory.add_entity(entity)


func _on_ui_summon(properties: Array[Property]) -> void:
	var dude: Dude = dude_factory.instantiate_dude()
	for property: Property in properties:
		property.reparent(dude)
		property.init(dude)
		dude_factory.spawn_constructed_dude(dude, true)


func _on_dude_container_dude_killed(_team: int) -> void:
	spawn_entity()
