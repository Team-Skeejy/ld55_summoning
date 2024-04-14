extends Node

@onready var parent: Entity = get_parent()

var dragging: bool = false
var force_multiplier: float = 1000
var torque_multiplier: float = 1000

var manual_friction: float = 0.5

var _drag_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	parent.input_event.connect(on_input_event)

func on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print(event)
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.pressed && ev.button_index == 1:
			dragging = true
			_drag_pos = parent.get_local_mouse_position()

func _input(event: InputEvent) -> void:
	if !dragging: return

	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.is_released && ev.button_index == 1:
			dragging = false

func _physics_process(_delta: float) -> void:
	if !dragging: return
	var drag_pos_relative_to_global: Vector2 = _drag_pos.rotated(parent.get_transform().get_rotation())
	var mouse_delta: Vector2 = parent.get_global_mouse_position() - parent.global_position - drag_pos_relative_to_global
	var angle: float = Vector2.UP.angle_to(drag_pos_relative_to_global)

	var force: Vector2 = mouse_delta * force_multiplier
	var torque: float = -angle * torque_multiplier

	parent.apply_force(force)
	parent.linear_velocity *= manual_friction

	parent.apply_torque(torque)
