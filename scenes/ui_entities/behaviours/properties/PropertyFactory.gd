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


static func get_dropped_property() -> Property:
	var obj: Array[String] = [
		"bow",
		"knife",
		"spear",
		"sword",
		"horse"
	]
	
	var item: String = obj[randi_range(0, obj.size() - 1)]
	
	return entity_by_name(item)
