extends Control
class_name FadeTransition

const MAIN_MENU: StringName = "res://scenes/main_menu.tscn"
const SPLASH_SCREEN: StringName = "res://scenes/splash_screen.tscn"
const GAME: StringName = "res://scenes/game.tscn"


@export var animationPlayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animationPlayer.play("fade_in")

var nextScene: StringName
func transition_to(scene: StringName) -> void:
	nextScene = scene;
	animationPlayer.play("fade_out")

func _change_scene() -> void:
	get_tree().change_scene_to_file(nextScene)
