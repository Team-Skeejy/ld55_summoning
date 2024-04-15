class_name End
extends Node

signal retry
signal return_to_menu

@export var screen: Control
@export var stats: Label
@export var audio: AudioStreamPlayer
@export var objects_collected: int = 0
@export var dudes_killed: int = 0

func show() -> void:
	var text = ""
	text += "Killed " + str(dudes_killed) + " Enemies\n"
	text += "Collected " + str(objects_collected) + " things"
	stats.text = text

	screen.visible = true
	get_tree().paused = true
	audio.play()

func hide() -> void:
	stats.text = ""
	screen.visible = false

func _on_button_button_down() -> void:
	retry.emit()
	get_tree().paused = false

func _on_button_2_button_down() -> void:
	return_to_menu.emit()
	get_tree().paused = false
