class_name UI
extends Node2D

signal summon()  # dunno what to put in this yet
signal forfeited()
signal retry()

@export var inventory: Inventory
@export var alter: Alter
@export var end: End

var timer: Timer

func _on_alter_summon(nodes: Array[Node2D]) -> void:

	var _entities: Array[Node2D] = nodes.filter(func(node: Node2D) -> bool: return node is Entity)

	# construct monster here i guess lol

	for node: Node2D in nodes:
		node.queue_free()
	reset_alter_buttons()

	summon.emit()

func reset_alter_buttons() -> void:
	await get_tree().process_frame
	alter.reevaluate_button_collisions()
	await get_tree().process_frame
	alter.reevaluate_button_collisions()
	await get_tree().process_frame
	alter.reevaluate_button_collisions()

func gameover() -> void:
	end.show()

func _on_forfeiting_forfeited() -> void:
	forfeited.emit()

func _on_end_retry() -> void:
	retry.emit()
