extends Node2D

@export var alter: Alter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_ui_button_pressed() -> void:
	# print_debug("pressed")
	pass

func _on_ui_button_over() -> void:
	# print_debug("over")
	pass

func _on_ui_button_button_up() -> void:
	# print_debug("up")
	pass

func _on_ui_button_button_down() -> void:
	# print_debug("down")
	pass

func reset_alter_buttons() -> void:
	await get_tree().process_frame
	alter.reevaluate_button_collisions()

func _on_alter_summon(entities: Array[Node2D]) -> void:
	for entity: Node2D in entities:
		entity.queue_free()
	reset_alter_buttons()

func _on_alter_summoning(remaining: float) -> void:
	print("summoning in " + str(remaining) + " seconds")
