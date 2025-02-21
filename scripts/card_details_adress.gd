extends PanelContainer

signal closed_button_pressed
signal address_deleted

@onready var edit_button: Button = %EditButton
@onready var save_button: Button = %SaveButton
@onready var cancel_button: Button = %CancelButton
@onready var edit_container: GridContainer = %EditContainer
@onready var display_container: GridContainer = %DisplayContainer

@onready var state_value: Label = %StateValue
@onready var city_value: Label = %CityValue
@onready var street_name_value: Label = %StreetNameValue
@onready var number_value: Label = %NumberValue

@onready var edit_state: LineEdit = %EditStateValue
@onready var edit_city: LineEdit = %EditCityValue
@onready var edit_street_name: LineEdit = %EditStreetNameValue
@onready var edit_number: SpinBox = %EditNumberSpinBox
@onready var delete_button: Button = %DeleteButton

@export var data: Resource :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()


func _set_values() -> void:
	# Display container
	if data is Address:
		state_value.text = data.state
		city_value.text = data.city
		street_name_value.text = data.street_name
		number_value.text = str(data.street_number)
		# Edit container
		edit_state.text = data.state
		edit_city.text = data.city
		edit_street_name.text = data.street_name
		edit_number.value = data.street_number


func _show_edit_menu() -> void:
	display_container.hide()
	edit_container.show()
	save_button.show()
	cancel_button.show()
	edit_button.hide()
	delete_button.show()

func _show_display_menu() -> void:
	edit_container.hide()
	display_container.show()
	edit_button.show()
	cancel_button.hide()
	save_button.hide()
	delete_button.hide()

func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()

func _on_save_button_pressed() -> void:
	_show_display_menu()
	if data is Address:
		data.state = edit_state.text
		data.city = edit_city.text
		data.street_name = edit_street_name.text
		data.street_number = edit_number.value
		_set_values()

func _on_cancel_button_pressed() -> void:
	_show_display_menu()
	_set_values()

func _on_edit_button_pressed() -> void:
	_show_edit_menu()

func _on_delete_button_pressed() -> void:
	Storage.save_file.address.erase(self.data)
	closed_button_pressed.emit()
	address_deleted.emit()
