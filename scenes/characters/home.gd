extends Attackable

class_name Home


# @export var Bar: ColorRect
signal killed()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 1000
	max_health = 1000
	team = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !is_dead and health < 0:
		killed.emit()
		is_dead = true

