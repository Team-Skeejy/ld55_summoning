extends Property

@export var arrow_scene: PackedScene  # = preload("res://scenes/ui_entities/behaviours/properties/attack/projectiles/arrow.tscn")

func _ready() -> void:
	name = "Bow"
	description = "Increases range"

	attack_power = 2
	attack_range = 25
	prevent_regular_attack = true

func init(_parent: Dude) -> void:
	super.init(_parent)
	_parent.on_attack.connect(attack)

func attack(target: Attackable) -> void:
	var arrow: Arrow = arrow_scene.instantiate()
	add_child(arrow)
	arrow.global_position = parent.global_position
	arrow.target = target
	arrow.attack_power = parent.attack_power

