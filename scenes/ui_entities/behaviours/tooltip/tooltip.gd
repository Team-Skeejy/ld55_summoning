class_name ToolTip
extends Node

static var instance: ToolTip

@export var label: Label
@export var tooltip: Control
@export var animation_player: AnimationPlayer


@export var tl_node: Control
@export var tr_node: Control
@export var bl_node: Control
@export var br_node: Control

static func get_instance() -> ToolTip:
	return instance

var hidden_colour: Color = Color.html("ffffff00")
var shown_colour: Color = Color.html("ffffffff")

var hidden: bool = true
var text: String = "":
	get:
		return text
	set(value):
		if (!value || value == "") && !hidden:
			hidden = true
			# animation_player.play("fade_out")
			tooltip.modulate = hidden_colour
		elif value.length() > 0 && hidden:
			hidden = false
			# animation_player.play("fade_in")
			tooltip.modulate = shown_colour
		text = value
		label.text = value

var parent: CollisionObject2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instance = self
	label.text = ""

func _physics_process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position() / get_viewport().get_visible_rect().size
	print(tooltip.size)

	if mouse_pos.x < 0.5:
		if mouse_pos.y < 0.5:
			tooltip.global_position = get_viewport().get_mouse_position() - tl_node.position
		else:
			tooltip.global_position = get_viewport().get_mouse_position() - bl_node.position - Vector2(0, 8)
	else:
		if mouse_pos.y < 0.5:
			tooltip.global_position = get_viewport().get_mouse_position() - tr_node.position - Vector2(8, 0)
		else:
			tooltip.global_position = get_viewport().get_mouse_position() - br_node.position - Vector2(8, 8)