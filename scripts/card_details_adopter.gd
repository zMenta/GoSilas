extends PanelContainer

signal closed_button_pressed
signal adopter_deleted

@onready var edit_button: Button = %EditButton
@onready var save_button: Button = %SaveButton
@onready var cancel_button: Button = %CancelButton
@onready var edit_container: GridContainer = %EditContainer
@onready var display_container: GridContainer = %DisplayContainer
@onready var name_value: Label = %NameValue
@onready var cpf_value: Label = %CpfValue
@onready var telephone_value: Label = %TelephoneValue
@onready var edit_name_value: LineEdit = %EditNameValue
@onready var edit_cpf_value: LineEdit = %EditCpfValue
@onready var edit_telephone_value: LineEdit = %EditTelephoneValue
@onready var delete_button: Button = %DeleteButton

@export var data: Resource :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()


func _set_values() -> void:
	# Display container
	if data is Adopter:
		name_value.text = data.name
		cpf_value.text = data.cpf
		telephone_value.text = data.telephone_number
		# Edit container
		edit_name_value.text = data.name
		edit_telephone_value.text = data.telephone_number
		edit_cpf_value.text = data.cpf


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
	if data is Adopter:
		data.name = edit_name_value.text
		data.cpf = edit_cpf_value.text
		data.telephone_number = edit_telephone_value.text
		_set_values()

func _on_cancel_button_pressed() -> void:
	_show_display_menu()
	_set_values()

func _on_edit_button_pressed() -> void:
	_show_edit_menu()

func _on_delete_button_pressed() -> void:
	Storage.save_file.adopter.erase(self.data)
	closed_button_pressed.emit()
	adopter_deleted.emit()
