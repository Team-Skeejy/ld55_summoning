extends Node2D

@export var flesh_spawner: Node2D;
@export var template_entity: Entity;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func child_killed():
	var second: Entity = template_entity.duplicate()
	second.global_position = flesh_spawner.global_position
	flesh_spawner.add_child(second)
	print("dude killed")
