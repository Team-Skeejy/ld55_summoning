class_name ToolTip
extends Node

static var instance: ToolTip

@export var label: Label
@export var tooltip: Control
@export var animation_player: AnimationPlayer

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
	tooltip.global_position = tooltip.get_global_mouse_position()
