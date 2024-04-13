extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ui_button_pressed():
	# print_debug("pressed")
	pass

func _on_ui_button_over():
	# print_debug("over")
	pass

func _on_ui_button_button_up():
	print_debug("up")

func _on_ui_button_button_down():
	print_debug("down")
