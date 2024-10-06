extends PanelContainer

signal closed_button_pressed

@onready var edit_button: Button = %EditButton
@onready var save_button: Button = %SaveButton
@onready var cancel_button: Button = %CancelButton
@onready var edit_container: GridContainer = %EditContainer
@onready var display_container: GridContainer = %DisplayContainer
@onready var is_castrated_checkbox: CheckBox = %IsCastratedCheckBox
@onready var sex_value: Label = %SexValue
@onready var size_value: Label = %SizeValue
@onready var character_value: Label = %CharacterValue
@onready var health_value: Label = %HealthValue

@export var data: Animal :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()

func _set_values() -> void:
	is_castrated_checkbox.button_pressed = data.is_castrated
	sex_value.text = str(data.Sex)
	character_value.text = str(data.Character)
	health_value.text = data.health_state

func _show_edit_menu() -> void:
	display_container.hide()
	edit_container.show()
	save_button.show()
	cancel_button.show()
	edit_button.hide()

func _show_display_menu() -> void:
	edit_container.hide()
	display_container.show()
	edit_button.show()
	cancel_button.hide()
	save_button.hide()


func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()

func _on_save_button_pressed() -> void:
	_show_display_menu()
	# Save contents to respective resource

func _on_cancel_button_pressed() -> void:
	_show_display_menu()
	# cancels

func _on_edit_button_pressed() -> void:
	_show_edit_menu()
