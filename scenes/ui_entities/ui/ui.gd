class_name UI
extends Node2D

signal summon(properties: Array[Property])  # dunno what to put in this yet
signal forfeited()
signal retry()
signal return_to_menu()
signal spike_state_change(raised: bool)

@export var inventory: Inventory
@export var alter: Alter
@export var end: End

@export var health_label: Label
@export var wave_label: Label

var timer: Timer

func _on_alter_summon(nodes: Array[Node2D]) -> void:
	var entities: Array[Node2D] = nodes.filter(func(node: Node2D) -> bool: return node is Entity)
	var properties: Array[Property] = []

	for entity: Entity in entities:
		for child: Node in entity.get_children():
			if child is Property:
				properties.push_back(child.duplicate())

	summon.emit(properties)

	# construct monster here i guess lol

	for node: Node2D in nodes:
		node.queue_free()
	reset_alter_buttons()

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


func set_health_as_percentage(value: float) -> void:
	health_label.text = "Health: %s %%" % int(value * 100)

func set_seconds_til_next_wave(value: int) -> void:
	wave_label.text = "Next Boss: %s" % value


func _on_btn_raise_spikes_button_up() -> void:
	spike_state_change.emit(false)

func _on_btn_raise_spikes_button_down() -> void:
	spike_state_change.emit(true)


func _on_end_return_to_menu() -> void:
	return_to_menu.emit()
