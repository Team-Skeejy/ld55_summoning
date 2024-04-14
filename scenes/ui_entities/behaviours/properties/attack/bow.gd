extends Property

@export var arrow_scene: PackedScene  # = preload("res://scenes/ui_entities/behaviours/properties/attack/projectiles/arrow.tscn")


func _ready() -> void:
	name = "Bow"
	description = "Increases range"

	attack_power = 2
	attack_range = 15

func init(_parent: Dude) -> void:
	super.init(_parent)
	_parent.on_attack.connect(attack)

func attack(target: Dude) -> void:
	var arrow: Arrow = arrow_scene.instantiate()
	arrow.target = target
	arrow.attack_power = parent.attack_power

