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

var _timer: float = 0

var _absolute_down: bool = false

func _on_area_2d_body_entered(_body: Node2D) -> void:
	_entity_over = true
	if !_mouse_pressed:
		_entity_on = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	if !area.has_overlapping_bodies():
		_entity_over = false
		_entity_on = false
		_entity_pressed = false

		if !_absolute_down:
			button_up.emit()
			_absolute_down = false

func _on_area_2d_mouse_shape_entered(_shape_idx: int) -> void:
	_mouse_over = true

func _on_area_2d_mouse_shape_exited(_shape_idx: int) -> void:
	_mouse_over = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if ev.pressed && ev.button_index == 1:
			if !_absolute_down:
				button_down.emit()
				_absolute_down = true
			_mouse_pressed = true
		if !ev.pressed && ev.button_index == 1:
			if !_absolute_down:
				button_up.emit()
				_absolute_down = false
			_mouse_pressed = false

func _process(delta: float) -> void:
	if _entity_on:
		if _timer < entity_press_duration:
			_timer += delta
		else:
			if !_entity_pressed && !_mouse_pressed:
				if !_absolute_down:
					button_down.emit()
					_absolute_down = true
			_entity_pressed = true
	else:
		_timer = 0

	if _mouse_over || _entity_over:
		over.emit()
	if _mouse_pressed || _entity_pressed:
		pressed.emit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event as InputEventMouseButton
		if !ev.pressed && ev.button_index == 1:
			_mouse_pressed = false
			if _entity_over:
				_entity_on = true
