extends Node

@onready var parent: Entity = get_parent()

var dragging: bool = false
var force_multiplier: float = 1000
var deadzone: float = 1
var deadzone_falloff: float = 50

func _ready() -> void:
	parent.input_event.connect(on_input_event)

func on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.pressed && ev.button_index == 1:
			dragging = true
	# elif event is InputEventScreenTouch:
	# 	var ev: InputEventScreenTouch = event as InputEventScreenTouch
	# 	if ev.pressed && ev.index == 1:
	# 		dragging = true

func _input(event: InputEvent) -> void:
	if !dragging: return

	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.is_released && ev.button_index == 1:
			dragging = false

	# elif event is InputEventScreenTouch:
	# 	var ev: InputEventScreenTouch = event as InputEventScreenTouch
	# 	if ev.is_released && ev.index == 1:
	# 		dragging = false


func _physics_process(delta: float) -> void:
	if !dragging: return
	var mouse_delta: Vector2 = parent.get_global_mouse_position() - parent.global_position


	var force: Vector2 = mouse_delta * force_multiplier * delta
	var til_deadzone: float = mouse_delta.length() - deadzone
	var normalised_force_curve: float = clampf(til_deadzone, 0, deadzone_falloff) / deadzone_falloff
	var falloff_applied: Vector2 = force.lerp(Vector2.ZERO, 1 - normalised_force_curve)

	parent.apply_impulse(falloff_applied)
	# parent.apply_impulse(Vector2.ONE)