class_name Alter
extends Node2D

signal summoning(remaining: float)
signal summon(nodes: Array[Node2D])
signal on_reevaluate_buttons

@export var alter_buttons: Array[UIButton]
@export var summon_area: Area2D
@export var summoning_sprite: AnimatedSprite2D

var _can_summon: bool = false

var summon_time: float = 1
var countdown: float = summon_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button: UIButton in alter_buttons:
		button.button_down.connect(check_buttons)
		button.button_up.connect(check_buttons)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _can_summon:
		countdown -= delta
		if countdown > 0:
			var frame_count: int = summoning_sprite.sprite_frames.get_frame_count("default")
			summoning_sprite.frame = int((summon_time - countdown) / summon_time * frame_count)
			summoning.emit(countdown)
		else:
			summon.emit(summon_area.get_overlapping_bodies())
			_can_summon = false
	else:
		countdown = 0
		summoning_sprite.frame = 0


func reevaluate_button_collisions() -> void:
	for button: UIButton in alter_buttons:
		button.reevaluate_collisions()
	on_reevaluate_buttons.emit()

func check_buttons() -> void:
	var exited_early: bool = false
	for button: UIButton in alter_buttons:
		if !button._absolute_down:
			exited_early = true
			break

	countdown = summon_time
	_can_summon = !exited_early
