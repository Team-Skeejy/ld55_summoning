extends Node2D

@onready var parent: Attackable = get_parent()

@export var ally_color: Color
@export var enemy_color: Color
@export var fgd: ColorRect

func _ready() -> void:
	pass
	match (parent.team):
		0:
			fgd.color = ally_color
		1:
			fgd.color = enemy_color

func _process(_delta: float) -> void:
	if parent.max_health > 500:
		print(parent.health)
		print(parent.health / parent.max_health)
	fgd.anchor_right = parent.health / parent.max_health
