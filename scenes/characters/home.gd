extends Attackable

@export var Bar: ColorRect

var width = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 100
	width = Bar.size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var size = Bar.size
	size.x = (health * 0.01) * width
	Bar.set_size(size)
	
