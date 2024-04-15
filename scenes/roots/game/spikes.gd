extends Node2D

@export var ui: UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child: Node2D in get_children():
		if child is Spike:
			ui.spike_state_change.connect((child as Spike).raise_spikes)

