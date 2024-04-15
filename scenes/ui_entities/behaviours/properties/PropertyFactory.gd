extends Object
class_name PropertyFactory

static var scenes: Dictionary = {}

static func entity_by_name(property_name: String) -> Property:
	if property_name.to_lower() in scenes:
		return scenes[property_name.to_lower()].instantiate()
	var prop = load("res://scenes/ui_entities/behaviours/properties/attack/" + property_name + ".tscn")
	if !prop:
		return
	scenes[property_name.to_lower()] = prop
	return prop.instantiate()
