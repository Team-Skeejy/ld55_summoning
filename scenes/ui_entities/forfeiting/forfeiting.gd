extends Node

signal forfeited

@export var fade_animation_player: AnimationPlayer
@export var warning_label: Label

var forfeit_time: float = 4

var _counter: float = 0
var _forfeiting: bool = false
var _forfeited: bool = false

func _ready() -> void:
	fade_animation_player.animation_finished.connect(ff)
	fade_animation_player.animation_finished.connect(reset)


func ff(anim_name: StringName) -> void:
	if anim_name == "timed_out":
		forfeited.emit()

func reset(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		_counter = 0

func forfeit() -> void:
	_forfeited = true
	warning_label.text = "YOU HAVE FORFEITED"
	fade_animation_player.play("timed_out")

func start() -> void:
	if _forfeited: return
	fade_animation_player.play("fade_in")
	_forfeiting = true

func stop() -> void:
	if _forfeited: return
	fade_animation_player.play("fade_out")
	_forfeiting = false

func _process(delta: float) -> void:
	if !_forfeiting || _forfeited: return
	_counter += delta

	warning_label.text = "YOU WILL FORFEIT IN: " + str(max(forfeit_time - _counter, 0)).left(3) + "s"

	if _counter > forfeit_time:
		forfeit()


