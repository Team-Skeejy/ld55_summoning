class_name Arrow
extends Sprite2D

@export var audio: AudioStreamPlayer

var target: Attackable
var target_vec: Vector2
var attack_power: float = 0

var speed: float = 50

func _ready() -> void:
	target_vec = target.global_position

var impact_time = 1
var impacted = false

func _process(delta: float) -> void:
	if !is_instance_valid(self):
		queue_free()
		return

	if global_position.distance_to(target_vec) < 1:
		if impacted:
			impact_time -= delta
			if impact_time < 0:
				queue_free()
		else:
			impacted = true
			audio.pitch_scale = randf_range(0.8, 1.2)
			audio.play()
			if is_instance_valid(target):
				target.health -= attack_power
	else:
		look_at(target_vec)
		global_position = global_position.move_toward(target_vec, speed * delta)

