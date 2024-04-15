extends Node
class_name Tutorial

@export var frames: Array[Control] = []

var stage: int = 0

func _ready() -> void:
	for i: int in range(len(frames)):
		var frame: Control = frames[i]
		frame.visible = false

func init() -> void:
	get_tree().paused = true
	for i: int in range(len(frames)):
		var frame: Control = frames[i]
		if i == stage:
			frame.visible = true
		else:
			frame.visible = false
	stage += 1

func next() -> void:
	if stage >= len(frames):
		skip()

	for i: int in range(len(frames)):
		var frame: Control = frames[i]
		if i == stage:
			frame.visible = true
		else:
			frame.visible = false

	stage += 1

func skip() -> void:
	for i: int in range(len(frames)):
		var frame: Control = frames[i]
		frame.visible = false
	stage = 0
	get_tree().paused = false
