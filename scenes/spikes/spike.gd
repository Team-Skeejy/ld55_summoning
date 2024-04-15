class_name Spike
extends AnimatedSprite2D

@export var hitbox: Area2D

var damage: float = 1

var spikes_up: bool = false

func _process(delta: float) -> void:
	if !spikes_up: return

	for body: Node2D in hitbox.get_overlapping_bodies():
		if body is Dude:
			print("damaging dude")
			(body as Dude).health -= damage * delta

func raise_spikes(value: bool) -> void:
	if spikes_up == value: return
	spikes_up = value
	if value:
		play()
	else:
		play_backwards()