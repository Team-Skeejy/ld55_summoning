extends Control

@export var fadeTransition: FadeTransition
@export var volume: HSlider

func _ready() -> void:
	get_tree().paused = false

	var volume_units: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	volume_units = remap(volume_units, -40, -4, 0, 100)
	volume.set_value_no_signal(volume_units)

func _on_h_slider_value_changed(value: float) -> void:
	var volume_db: float = remap(value, 0, 100, -40, -4)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)

func _on_btn_start_button_down():
	fadeTransition.transition_to(fadeTransition.GAME)
