extends PanelContainer

signal closed_button_pressed

@onready var edit_button: Button = %EditButton
@onready var save_button: Button = %SaveButton
@onready var cancel_button: Button = %CancelButton
@onready var edit_container: GridContainer = %EditContainer
@onready var display_container: GridContainer = %DisplayContainer
@onready var name_label: Label = %NameLabel
@onready var name_value: Label = %NameValue
@onready var is_castrated_checkbox: CheckBox = %IsCastratedCheckBox
@onready var sex_value: Label = %SexValue
@onready var size_value: Label = %SizeValue
@onready var character_value: Label = %CharacterValue
@onready var health_value: Label = %HealthValue
@onready var edit_is_castrated_check_box: CheckBox = %EditIsCastratedCheckBox
@onready var edit_sex_option: OptionButton = %EditSexOption
@onready var edit_size_option: OptionButton = %EditSizeOption
@onready var edit_character_option: OptionButton = %EditCharacterOption
@onready var edit_health_value: LineEdit = %EditHealthValue
@onready var edit_name_value: LineEdit = %EditNameValue
@onready var edit_image_button : Button = %EditImageButton

@export var data: Animal :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()


func _set_values() -> void:
	# Display container
	name_value.text = data.name
	is_castrated_checkbox.button_pressed = data.is_castrated
	match data.Sex:
		0: sex_value.text = "Male"
		1: sex_value.text = "Female"
	match data.Character:
		0: character_value.text = "Friendly"
		1: character_value.text = "Agressive"
	match data.Size:
		0: size_value.text = "Small"
		1: size_value.text = "Medium"
		2: size_value.text = "Big"
		3: size_value.text = "Extra Big"
	health_value.text = data.health_state
	# Edit container
	edit_name_value.text = data.name
	edit_is_castrated_check_box.button_pressed = data.is_castrated
	edit_sex_option.selected = data.Sex
	edit_character_option.selected = data.Character
	edit_size_option.selected = data.Size
	edit_health_value.text = data.health_state


func _show_edit_menu() -> void:
	display_container.hide()
	edit_container.show()
	save_button.show()
	cancel_button.show()
	edit_button.hide()
	edit_image_button.show()


func _show_display_menu() -> void:
	edit_container.hide()
	display_container.show()
	edit_button.show()
	cancel_button.hide()
	save_button.hide()
	edit_image_button.hide()


func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()

func _on_save_button_pressed() -> void:
	_show_display_menu()
	data.name = edit_name_value.text
	data.is_castrated = edit_is_castrated_check_box.button_pressed
	data.Sex = edit_sex_option.selected
	data.Character = edit_character_option.selected
	data.Size = edit_size_option.selected
	data.health_state = edit_health_value.text
	_set_values()

func _on_cancel_button_pressed() -> void:
	_show_display_menu()
	_set_values()

func _on_edit_button_pressed() -> void:
	_show_edit_menu()
