extends PanelContainer

signal create_card_cancel_pressed

func _on_cancel_button_pressed() -> void:
	create_card_cancel_pressed.emit()

