extends PanelContainer

signal create_card_cancel_pressed
signal address_created(address: Address)

@onready var edit_state: LineEdit = %EditStateValue
@onready var edit_city: LineEdit = %EditCityValue
@onready var edit_street_name: LineEdit = %EditStreetNameValue
@onready var edit_number: SpinBox = %EditNumberSpinBox

func clear_fields() -> void:
	edit_state.text = ""
	edit_city.text = ""
	edit_street_name.text = ""
	edit_number.value = 0

func _on_cancel_button_pressed() -> void:
	create_card_cancel_pressed.emit()
	clear_fields()

func _on_save_button_pressed() -> void:
	var new_address: Address = Address.new()
	new_address.state = edit_state.text
	new_address.city = edit_city.text
	new_address.street_name = edit_street_name.text
	new_address.street_number = int(edit_number.value)
	address_created.emit(new_address)
	clear_fields()
