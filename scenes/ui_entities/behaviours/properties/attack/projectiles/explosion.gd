class_name Explosion
extends Node2D

@export var audio: AudioStreamPlayer
@export var animated_sprite: AnimatedSprite2D
@export var area2d: Area2D

var attack_power: float = 0
var parent: Dude

func explode():
	visible = true
	audio.pitch_scale = randf_range(0.8, 1.2)
	audio.play()
	animated_sprite.play()
	audio.finished.connect(func() -> void: queue_free())

	for node2D: Node2D in area2d.get_overlapping_bodies():
		print(node2D)
		if node2D is Dude:
			(node2D as Dude).health -= attack_power

	parent.health = 0
