extends PanelContainer

signal create_card_cancel_pressed
signal animal_created(animal: Animal)

var file_dialog: FileDialog = null

@onready var image_rect: TextureRect = %TextureRect
@onready var edit_name_value: LineEdit = %EditNameValue
@onready var edit_is_castrated_check_box: CheckBox = %EditIsCastratedCheckBox
@onready var edit_sex_option: OptionButton = %EditSexOption
@onready var edit_size_option: OptionButton = %EditSizeOption
@onready var edit_character_option: OptionButton = %EditCharacterOption
@onready var edit_health_value: LineEdit = %EditHealthValue

func clear_fields() -> void:
	# TODO, add a default image for the animal
	image_rect.texture = null
	edit_name_value.text = ""
	edit_is_castrated_check_box.button_pressed = false
	edit_sex_option.selected = 0
	edit_size_option.selected = 0
	edit_character_option.selected = 0
	edit_health_value.text = ""

func _on_cancel_button_pressed() -> void:
	create_card_cancel_pressed.emit()
	clear_fields()

func _on_save_button_pressed() -> void:
	var new_animal: Animal = Animal.new()
	new_animal.image = image_rect.texture
	new_animal.name = edit_name_value.text
	new_animal.is_castrated = edit_is_castrated_check_box.button_pressed
	new_animal.Sex = edit_sex_option.selected
	new_animal.Size = edit_size_option.selected
	new_animal.Character = edit_character_option.selected
	new_animal.health_state = edit_health_value.text
	animal_created.emit(new_animal)
	clear_fields()

func _on_edit_image_button_pressed() -> void:
	if file_dialog == null:
		return
	file_dialog.show()

func _on_file_dialog_file_selected(path:String) -> void:
	var image: Image = Image.load_from_file(path)
	image_rect.texture = ImageTexture.create_from_image(image)
