class_name Inventory
extends Node2D

@export var dimensions: Vector2i
@export var storage_space: CollisionShape2D

@export var audio: AudioStreamPlayer

@export var debug_sprite: Sprite2D
@export var area: Rect2

var radius: float = 1

var _colliders: Array[Area2D]

func _ready() -> void:
	for j: int in dimensions.y:
		for i: int in dimensions.x:
			var area_2d: Area2D = Area2D.new()
			var collision_shape: CollisionShape2D = CollisionShape2D.new()
			var circle: CircleShape2D = CircleShape2D.new()
			circle.radius = radius
			collision_shape.shape = circle

			area_2d.add_child(collision_shape)

			var sprite: Sprite2D = debug_sprite.duplicate()
			area_2d.add_child(sprite)

			add_child(area_2d)
			area_2d.position = area.position + area.size * (Vector2(i / float(dimensions.x), j / float(dimensions.y))) + area.size / Vector2(dimensions) / 2

			_colliders.append(area_2d)

func add_entity(entity: Entity) -> void:
	var unplaced: bool = true
	for collider: Area2D in _colliders:
		if !collider.has_overlapping_bodies():
			entity.position = collider.position
			unplaced = false
			break
	if unplaced:
		entity.position = Vector2(randf_range(area.position.x, area.end.x), randf_range(area.position.y, area.end.y))

	if !entity.get_parent():
		self.add_child(entity)
	else:
		entity.reparent(self)

	freeze(entity)
	audio.pitch_scale = randf_range(0.8, 1.2)
	audio.play()


func freeze(entity: Entity) -> void:
	await get_tree().process_frame
	entity.linear_velocity = Vector2.ZERO

func clear():
	var items = get_children().filter(func(child: Node2D): return child is Entity and child.visible)
	for item in items:
		item.queue_free()
