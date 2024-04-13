class_name UIButton
extends Sprite2D

signal button_down
signal button_up
signal over
signal pressed

@export var area: Area2D

var entity_press_duration: float = 0.5;

var _entity_over: bool = false
var _entity_on: bool = false
var _entity_pressed: bool = false
var _mouse_over: bool = false
var _mouse_pressed: bool = false
var _mouse_down: bool = false

var _timer: float = 0

var _absolute_down: bool = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	_entity_over = true
	if !_mouse_down:
		_entity_on = true

	reevaluate_ui_state()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	if area.has_overlapping_bodies(): return
	_entity_over = false
	_entity_on = false
	_entity_pressed = false

	if _absolute_down:
		_absolute_down = false
		button_up.emit()

	reevaluate_ui_state()

func _on_area_2d_mouse_shape_entered(_shape_idx: int) -> void:
	_mouse_over = true
	reevaluate_ui_state()

func _on_area_2d_mouse_shape_exited(_shape_idx: int) -> void:
	_mouse_over = false
	_mouse_pressed = false
	reevaluate_ui_state()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.pressed && ev.button_index == 1:
			if !_absolute_down:
				_absolute_down = true
				button_down.emit()
			_mouse_pressed = true
		if !ev.pressed && ev.button_index == 1:
			if _absolute_down && !area.has_overlapping_bodies():
				_absolute_down = false
				button_up.emit()
			_mouse_pressed = false
		reevaluate_ui_state()

func _process(delta: float) -> void:
	if _entity_on:
		if _timer < entity_press_duration:
			_timer += delta
		else:
			if !_entity_pressed && !_mouse_pressed:
				if !_absolute_down:
					_absolute_down = true
					button_down.emit()
			_entity_pressed = true
			reevaluate_ui_state()
	else:
		if _timer != 0:
			reevaluate_ui_state()
		_timer = 0

	if _mouse_over || _entity_over:
		over.emit()
	if _mouse_pressed || _entity_pressed:
		pressed.emit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.button_index == 1:
			if ev.pressed:
				_mouse_down = true
			else:
				_mouse_down = false
				_mouse_pressed = false
				if _entity_over:
					_entity_on = true
			reevaluate_ui_state()

func reset() -> void:
	_entity_over = false
	_entity_on = false
	_entity_pressed = false

func reevaluate_collisions() -> void:
	var colliding: bool = area.has_overlapping_bodies()
	_entity_over = colliding
	_entity_on = colliding
	_entity_pressed = colliding

func reevaluate_ui_state() -> void:
	if _entity_pressed || _mouse_pressed:
		frame = 2
	elif _entity_over || _mouse_over || _entity_on:
		frame = 1
	else:
		frame = 0
