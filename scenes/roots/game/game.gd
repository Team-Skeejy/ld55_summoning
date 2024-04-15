extends Node2D
class_name Game

@export var interval_spawn_rate: float = 10
@export var test_entity: PackedScene
@export var ui: UI
@export var dude_container: DudeContainer
@export var wave_machine: WaveController
@export var fade_transition: FadeTransition

func _ready() -> void:
	reset()


func _process(_delta: float) -> void:
	ui.set_seconds_til_next_wave(int(wave_machine.boss_interval - wave_machine.boss_timer))
	ui.set_health_as_percentage(dude_container.good_home.health / dude_container.good_home.max_health)

func spawn_entity() -> void:
	var property: Property = PropertyFactory.get_dropped_property()
	var entity: Entity = test_entity.instantiate()
	add_child(entity)
	entity.add_child(property)
	entity.use_skin_for(property)
	ui.inventory.add_entity(entity)


func _on_ui_summon(properties: Array[Property]) -> void:
	dude_container.spawn_dude(true, properties)


func _on_dude_container_dude_killed(team: int) -> void:
	if team == 1:
		ui.end.dudes_killed += 1
	spawn_entity()
	ui.end.objects_collected += 1


func _on_house_killed(team: int) -> void:
	if team == 0:
		ui.gameover()
	else:
		reset()
	pass  # Replace with function body.


func _on_ui_retry() -> void:
	restart()

func reset() -> void:
	ui.end.hide()
	ui.inventory.clear()
	dude_container.setup()
	#spawn five at the start of the round so we can get started
	for i: int in [1, 2, 3, 4, 5]:
		spawn_entity()

	#dude_container.spawn_dude(true, [
	#	PropertyFactory.entity_by_name("bow")
	#])
	#dude_container.spawn_dude(false, [])

func restart() -> void:
	fade_transition.transition_to(fade_transition.GAME)


func _on_ui_forfeited() -> void:
	ui.gameover()


func _on_wave_controller_boss_spawn() -> void:
	pass


func _on_wave_controller_enemy_spawn() -> void:
	pass


func _on_ui_return_to_menu() -> void:
	fade_transition.transition_to(fade_transition.MAIN_MENU)