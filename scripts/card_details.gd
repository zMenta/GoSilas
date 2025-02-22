extends PanelContainer

signal closed_button_pressed
signal animal_deleted

var file_dialog: FileDialog = null
var entity_line: PackedScene = preload("res://scenes/entity_line.tscn")

@onready var image_rect: TextureRect = %ImageRect
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
@onready var delete_button: Button = %DeleteButton
@onready var adopter_container: VBoxContainer = %AdopterContainer
@onready var address_container: VBoxContainer = %AddressContainer
@onready var adopter_edit_button: Button = %AdopterEditButton
@onready var address_edit_button: Button = %AddressEditButton

@export var data: Resource :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()

func _ready() -> void:
	GlobalSignals.entity_picker_confirm_pressed.connect(_on_entity_picker_button_pressed)

func _set_values() -> void:
	# Display container
	image_rect.texture = data.image
	name_value.text = data.name
	is_castrated_checkbox.button_pressed = data.is_castrated
	match data.Sex:
		0: sex_value.text = "Masculino"
		1: sex_value.text = "Feminino"
	match data.Character:
		0: character_value.text = "Amigável"
		1: character_value.text = "Agressivo"
	match data.Size:
		0: size_value.text = "Pequeno"
		1: size_value.text = "Médio"
		2: size_value.text = "Grande"
		3: size_value.text = "Extra Grande"
	health_value.text = data.health_state
	# Edit container
	edit_name_value.text = data.name
	edit_is_castrated_check_box.button_pressed = data.is_castrated
	edit_sex_option.selected = data.Sex
	edit_character_option.selected = data.Character
	edit_size_option.selected = data.Size
	edit_health_value.text = data.health_state
	_add_related_entities()


func _add_related_entities() -> void:
	for child in adopter_container.get_children():
		child.queue_free()
	for child in address_container.get_children():
		child.queue_free()

	if data.adopter != null:
		var adopter_line: EntityLine = entity_line.instantiate()
		adopter_container.add_child(adopter_line)
		adopter_line.data = data.adopter

	if data.address != null:
		var address_line: EntityLine = entity_line.instantiate()
		address_container.add_child(address_line)
		address_line.data = data.address


func _show_edit_menu() -> void:
	display_container.hide()
	edit_container.show()
	save_button.show()
	cancel_button.show()
	edit_button.hide()
	edit_image_button.show()
	delete_button.show()
	adopter_edit_button.show()
	address_edit_button.show()

func _show_display_menu() -> void:
	edit_container.hide()
	display_container.show()
	edit_button.show()
	cancel_button.hide()
	save_button.hide()
	edit_image_button.hide()
	delete_button.hide()
	adopter_edit_button.hide()
	address_edit_button.hide()

func _on_close_button_pressed() -> void:
	closed_button_pressed.emit()

func _on_save_button_pressed() -> void:
	_show_display_menu()
	data.image = image_rect.texture
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

func _on_edit_image_button_pressed() -> void:
	if file_dialog == null:
		return
	file_dialog.show()

func _on_file_dialog_file_selected(path:String) -> void:
	var image: Image = Image.load_from_file(path)
	image_rect.texture = ImageTexture.create_from_image(image)


func _on_delete_button_pressed() -> void:
	Storage.save_file.animals.erase(self.data)
	closed_button_pressed.emit()
	animal_deleted.emit()

func _on_address_edit_button_pressed() -> void:
	GlobalSignals.card_detail_edit_address_button_pressed.emit(data)

func _on_adopter_edit_button_pressed() -> void:
	GlobalSignals.card_detail_edit_adopter_button_pressed.emit(data)

func _on_entity_picker_button_pressed() -> void:
	_set_values()

