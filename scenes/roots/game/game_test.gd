extends Node2D

@export var game: Game
@export var base_entity: PackedScene

func spawn_entity(property_name: String) -> void:
	var entity: Entity = base_entity.instantiate()
	var prop: Property = PropertyFactory.entity_by_name(property_name)
	entity.add_child(prop)
	game.ui.inventory.add_entity(entity)


