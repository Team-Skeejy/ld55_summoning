extends Node

@export var label: Label

var parent: CollisionObject2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p: Node = get_parent()
	if p is CollisionObject2D:
		parent = (p as CollisionObject2D)
		parent.mouse_shape_entered.connect(make_visible)
		parent.mouse_shape_exited.connect(make_invisible)

func make_visible():
	pass

func make_invisible():
	pass