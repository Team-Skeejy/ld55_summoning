extends Control

@export var textedit: TextEdit

func _on_text_edit_text_changed() -> void:
	ToolTip.get_instance().text = textedit.text
