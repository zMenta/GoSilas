extends PanelContainer

signal closed_button_pressed

@onready var is_castrated_label: Label = %IsCastratedLabel
@onready var is_castrated_checkbox: CheckBox = %IsCastratedCheckBox
@onready var sex_label: Label = %SexLabel
@onready var sex_value: Label = %SexValue
@onready var size_label: Label = %SizeLabel
@onready var size_value: Label = %SizeValue
@onready var character_label: Label = %CharacterLabel
@onready var character_value: Label = %CharacterValue
@onready var health_label: Label = %HealthLabel
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


func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()
