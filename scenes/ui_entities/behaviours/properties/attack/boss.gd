extends Property


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name = "Boss item"
	description = "Makes you the boss"

	health = 100
	attack_power = 10
	attack_range = 1
	prevent_regular_attack = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
