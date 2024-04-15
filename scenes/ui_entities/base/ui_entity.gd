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
	var name = prop.name.to_lower()
	if name == "bow": 
		sprite.frame = 3
	elif name == "knife":
		sprite.frame = 0
	elif name == "spear":
		sprite.frame = 2
	elif name == "sword":
		sprite.frame = 1
