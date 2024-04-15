class_name Entity
extends RigidBody2D

@export var collider: CollisionShape2D
@export var sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func use_skin_for(prop: Property) -> void:
	var name = prop.chosen_name.to_lower()
	match name:
		"bow":
			sprite.frame = 3
		"knife":
			sprite.frame = 0
		"spear":
			sprite.frame = 2
		"sword":
			sprite.frame = 1
		"horse":
			sprite.frame = 10
		"meat":
			sprite.frame = 11
		"bomb":
			sprite.frame = 6

func _on_mouse_exited() -> void:
	ToolTip.get_instance().text = ""

func _on_mouse_entered() -> void:
	var texts: PackedStringArray = PackedStringArray()
	for child: Node in get_children():
		if child is Property:
			texts.push_back((child as Property).chosen_name + "\n\n" + (child as Property).description)
	ToolTip.get_instance().text = "\n\n\n".join(texts)


