extends Property
@export var explosion: PackedScene

var explode: Explosion
var ready_to_explode: bool = false

func _ready() -> void:
	chosen_name = "Bomb"
	description = "WE RUN AND WE EXPLODE!"

	prevent_regular_attack = true
	attack_power = 20
	speed = 15
	attack_interval = 0.01

func init(_parent: Dude) -> void:
	super.init(_parent)
	_parent.on_attack.connect(attack)

	explode = explosion.instantiate() as Explosion
	explode.attack_power = _parent.attack_power
	explode.parent = _parent
	parent.parentContainer.add_child(explode)
	ready_to_explode = true

func _process(_delta: float) -> void:
	if !ready_to_explode: return
	explode.global_position = parent.global_position

func attack(_target: Attackable) -> void:
	await get_tree().process_frame
	explode.explode()
