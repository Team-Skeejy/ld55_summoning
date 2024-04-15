extends Node2D

@export var game: Game
@export var base_entity: PackedScene

func spawn_entity(property_name: String) -> void:
	var entity: Entity = base_entity.instantiate()
	var prop: Property = PropertyFactory.entity_by_name(property_name)
	entity.add_child(prop)
	game.ui.inventory.add_entity(entity)

func spawn_bow() -> void:
	var items: Array[Property] = [ 
		get_bow(),
		get_bow(),
		get_bow(),
		get_bow(),
		get_bow()
	]
	game.dude_container.spawn_dude(true, items)
	
func get_bow() -> Property:
	return PropertyFactory.entity_by_name("bow")
