extends Node2D

signal summoning(remaining: float)
signal summon

@export var alter_buttons: Array[UIButton]
@export var summon_area: Area2D

var _can_summon: bool = false

var summon_time: float = 3
var countdown: float = summon_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button: UIButton in alter_buttons:
		button.button_down.connect(check_buttons)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _can_summon:
		countdown -= delta
		summoning.emit(countdown)
		if countdown <= 0:
			countdown = summon_time
			summon.emit(summon_area.get_overlapping_bodies())

func check_buttons() -> void:
	var exited_early: bool = false
	for button: UIButton in alter_buttons:
		if !button._absolute_down:
			exited_early = true
			break

	if !exited_early:
		_can_summon = true;