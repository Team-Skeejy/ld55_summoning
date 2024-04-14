extends Node2D

@export var ui: UI

@export var test_entity: PackedScene

func _on_button_button_down() -> void:
	print("adding item")
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	ui.inventory.add_entity(entity)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
