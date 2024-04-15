extends Control
class_name FadeTransition

const SPLASH_SCREEN: StringName = "res://scenes/roots/splash/splash_screen.tscn"
const MAIN_MENU: StringName = "res://scenes/roots/main/menu.tscn"
const GAME: StringName = "res://scenes/roots/game/game.tscn"


@export var animationPlayer: AnimationPlayer

@onready var starting_volume: float = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationPlayer.play("fade_in")

var nextScene: StringName
func transition_to(scene: StringName) -> void:
	nextScene = scene;
	animationPlayer.play("fade_out")

func _change_scene() -> void:
	get_tree().change_scene_to_file(nextScene)
