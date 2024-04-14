extends Node2D

@export var properties: Dictionary
@export var game: Game
@export var base_entity: PackedScene

func spawn_entity(property_name: String) -> void:
	var entity: Entity = base_entity.instantiate()
	if properties.has(property_name):
		# fuck you godot
		var prop_base: PackedScene = properties[property_name] as PackedScene
		if prop_base is PackedScene:
			var prop: Property = (prop_base).instantiate() as Property
			entity.add_child(prop)

	game.ui.inventory.add_entity(entity)


