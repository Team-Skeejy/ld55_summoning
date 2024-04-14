class_name UI
extends Node2D

signal summon()  # dunno what to put in this yet

@export var inventory: Inventory
@export var alter: Alter

func _on_alter_summon(nodes: Array[Node2D]) -> void:

	var _entities: Array[Entity] = nodes.filter(func(node: Node2D) -> bool: return node is Entity)

	# construct monster here i guess lol

	for node: Node2D in nodes:
		node.queue_free()
	reset_alter_buttons()

	summon.emit()

func reset_alter_buttons() -> void:
	await get_tree().process_frame
	alter.reevaluate_button_collisions()


func _on_forfeit_button_down() -> void:
	pass # Replace with function body.
