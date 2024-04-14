class_name Inventory
extends Node2D

@export var dimensions: Vector2i
@export var storage_space: CollisionShape2D

@export var debug_sprite: Sprite2D
@export var area: Rect2

var radius: float = 1

var _colliders: Array[Area2D]

func _ready() -> void:
	for i: int in dimensions.x:
		for j: int in dimensions.y:
			var area_2d: Area2D = Area2D.new()
			var collision_shape: CollisionShape2D = CollisionShape2D.new()
			var circle: CircleShape2D = CircleShape2D.new()
			circle.radius = radius
			collision_shape.shape = circle

			area_2d.add_child(collision_shape)

			var sprite: Sprite2D = debug_sprite.duplicate()
			area_2d.add_child(sprite)

			add_child(area_2d)
			area_2d.position = area.size * (Vector2(i / float(dimensions.x), j / float(dimensions.y))) + area.size / Vector2(dimensions) / 2

			_colliders.append(area_2d)

func add_entity(entity: Entity) -> void:
	pass
