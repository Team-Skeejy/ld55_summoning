extends Control

var dude = load("res://scenes/characters/Dude.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var spawn_interval = 10
var time_passed = 0

func _process(delta):
	time_passed += delta
	if(time_passed > spawn_interval):
		time_passed = 0
		var new_dude = dude.instantiate()
		
		new_dude.parentContainer = $DudeContainer
		var team = randi_range(1,2)
		new_dude.team = team
		if(team == 1):
			new_dude.homeNode = $Home1
			new_dude.global_position = $Home1.global_position
		else:
			new_dude.homeNode = $Home2
			new_dude.global_position = $Home2.global_position
		$DudeContainer.add_child(new_dude)
	pass
