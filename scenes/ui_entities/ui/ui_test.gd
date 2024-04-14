extends Node2D

@export var ui: UI
@export var test_entity: PackedScene

func _on_button_button_down() -> void:
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	ui.inventory.add_entity(entity)

