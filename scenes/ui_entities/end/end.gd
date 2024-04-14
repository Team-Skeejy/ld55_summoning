class_name End
extends Node

signal retry

@export var screen: Control
@export var audio: AudioStreamPlayer

func show() -> void:
	screen.visible = true
	audio.play()

func _on_button_button_down() -> void:
	retry.emit()


