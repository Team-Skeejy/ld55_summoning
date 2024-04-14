extends Node2D

@export var inventory: Inventory

func _on_button_button_down() -> void:
	inventory.add_entity()
