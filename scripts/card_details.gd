extends PanelContainer

signal closed_button_pressed
@export var data: Resource

func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()
