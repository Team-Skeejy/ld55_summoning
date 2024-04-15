class_name Property
extends Node

var parent: Dude
var description: String
var effects: String

var health: int = 0
var attack_power: int = 0
var speed: float = 0
var attack_range: float = 0
var attack_interval: float = 1
var prevent_regular_attack: bool = false

func _ready() -> void:
	# name = "This is a base property for items"
	# description = "You forgot to add a description"

	# health = 0
	# attack_power = 0
	# speed = 0
	# attack_range = 0
	# attack_interval = 1
	pass


func init(_parent: Dude) -> void:
	parent = _parent
	parent.health += health
	parent.max_health += health
	parent.attack_power += attack_power
	parent.speed += speed
	parent.attack_range += attack_range
	parent.attack_interval *= attack_interval
	parent.prevent_regular_attack = prevent_regular_attack
