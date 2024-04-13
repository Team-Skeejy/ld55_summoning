extends Control

@export var animationPlayer: AnimationPlayer
@export var fadeTransition: FadeTransition

const nextScene: StringName = "res://scenes/game/game.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -4)
	if OS.get_name() == "Web":
		get_tree().change_scene_to_file(nextScene)
	else:
		animationPlayer.play("sleepy_fade")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://scenes/menu/game.tscn")
	if Input.is_action_just_pressed("Tab"):
		get_tree().change_scene_to_file("res://scenes/menu/game.tscn")

	if Input.is_anything_pressed():
		fadeTransition.transition_to(nextScene)

func _on_animation_player_animation_finished(animation: StringName) -> void:
	fadeTransition.transition_to(nextScene)
