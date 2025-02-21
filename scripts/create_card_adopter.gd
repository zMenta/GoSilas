extends PanelContainer

signal create_card_cancel_pressed
signal adopter_created(animal: Adopter)

@onready var edit_name_value: LineEdit = %EditNameValue
@onready var edit_cpf_value: LineEdit = %EditCpfValue
@onready var edit_telephone_value: LineEdit = %EditTelephoneValue

func clear_fields() -> void:
	edit_name_value.text = ""
	edit_cpf_value.text = ""
	edit_telephone_value.text = ""

func _on_cancel_button_pressed() -> void:
	create_card_cancel_pressed.emit()
	clear_fields()

func _on_save_button_pressed() -> void:
	var new_adopter: Adopter = Adopter.new()
	new_adopter.name = edit_name_value.text
	new_adopter.cpf = edit_cpf_value.text
	new_adopter.telephone_number = edit_telephone_value.text
	adopter_created.emit(new_adopter)
	clear_fields()
