extends PanelContainer

@onready var file_dialog: FileDialog = %FileDialog
@onready var card_container : HFlowContainer = %CardContainer
@onready var left_container : MarginContainer = %LeftContainer
@onready var main_split_container : HSplitContainer = %MainSplitContainer
@onready var create_card : PanelContainer = %CreateCard
@onready var create_adopter_card: PanelContainer = %CreateCardAdopter
@onready var create_address_card: PanelContainer = %CreateCardAddress
@onready var details_card_animal : PanelContainer = %CardDetails
@onready var details_card_adopter: PanelContainer = %CardDetailsAdopter
@onready var details_card_address: PanelContainer = %CardDetailsAdress
@onready var add_animal_button: Button = %AddAnimal
@onready var add_adopter_button: Button = %AddAdopter
@onready var add_address_button: Button = %AddAddress
@onready var filter_line_edit: LineEdit = %FilterLineEdit

@onready var entity_picker_menu: PopupPanel = %ResourcePickerMenu
@onready var entity_picker := %EntityPicker

enum CardEntities {animal, adopter, address}
var current_card_entity: int = 0

const CARD: PackedScene = preload("res://scenes/card.tscn")

func _ready() -> void:
	details_card_animal.file_dialog = file_dialog
	create_card.file_dialog = file_dialog
	GlobalSignals.card_pressed.connect(_on_card_pressed)
	GlobalSignals.card_detail_edit_adopter_button_pressed.connect(_on_card_edit_adopter)
	GlobalSignals.card_detail_edit_address_button_pressed.connect(_on_card_edit_address)
	GlobalSignals.entity_picker_confirm_pressed.connect(_on_entity_confirm_button_pressed)
	_on_animal_button_pressed()

func _check_dragger_visibility() -> void:
	# if left_container.visible == true:
	# 	main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_VISIBLE
	# else:
	# 	main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_HIDDEN_COLLAPSED
	pass

func _on_card_details_closed_button_pressed() -> void:
	details_card_animal.show()
	left_container.visible = false
	_check_dragger_visibility()

func _on_create_card_create_card_cancel_pressed() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	left_container.hide()
	_check_dragger_visibility()

func _on_create_card_created(data: Resource) -> void:
	var card := CARD.instantiate()
	card.data = data
	if data is Animal:
		card_container.add_child(card)
		Storage.save_file.animals.append(data)
	if data is Adopter:
		card_container.add_child(card)
		Storage.save_file.adopter.append(data)
	if data is Address:
		card_container.add_child(card)
		Storage.save_file.address.append(data)

func _on_card_pressed(data: Resource) -> void:
	for child:Control in left_container.get_children():
		child.hide()
	if data is Animal:
		details_card_animal.show()
		details_card_animal.data = data
	elif data is Adopter:
		details_card_adopter.show()
		details_card_adopter.data = data
	elif data is Address:
		details_card_address.show()
		details_card_address.data = data
	left_container.show()
	_check_dragger_visibility()

func _clear_card_container() -> void:
	for child in card_container.get_children():
		child.queue_free()

func _on_address_button_pressed(addresses: Array[Address] = Storage.save_file.address) -> void:
	current_card_entity = CardEntities.address
	add_animal_button.hide()
	add_adopter_button.hide()
	add_address_button.show()
	_clear_card_container()
	_on_create_card_create_card_cancel_pressed()
	for address in addresses:
		var card := CARD.instantiate()
		card.data = address
		card_container.add_child(card)

func _on_adopter_button_pressed(adopters: Array[Adopter] = Storage.save_file.adopter) -> void:
	current_card_entity = CardEntities.adopter
	add_animal_button.hide()
	add_adopter_button.show()
	add_address_button.hide()
	_clear_card_container()
	_on_create_card_create_card_cancel_pressed()
	for adopter in adopters:
		var card := CARD.instantiate()
		card.data = adopter
		card_container.add_child(card)

func _on_animal_button_pressed(animals: Array[Animal] = Storage.save_file.animals) -> void:
	current_card_entity = CardEntities.animal
	add_animal_button.show()
	add_adopter_button.hide()
	add_address_button.hide()
	_clear_card_container()
	_on_create_card_create_card_cancel_pressed()
	for animal in animals:
		var card := CARD.instantiate()
		card.data = animal
		card_container.add_child(card)

func _create_ui_card_setup() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	left_container.show()
	_check_dragger_visibility()

# Add buttons 
func _on_add_button_pressed() -> void:
	_create_ui_card_setup()
	create_card.show()

func _on_add_address_pressed() -> void:
	_create_ui_card_setup()
	create_address_card.show()

func _on_add_adopter_pressed() -> void:
	_create_ui_card_setup()
	create_adopter_card.show()

func _on_card_details_animal_deleted() -> void:
	_on_animal_button_pressed()

func _on_card_details_adress_address_deleted() -> void:
	_on_address_button_pressed()

func _on_card_details_adopter_adopter_deleted() -> void:
	_on_adopter_button_pressed()

func _on_filter_clear_button_pressed() -> void:
	filter_line_edit.text = ""
	_on_filter_button_pressed()

func _on_filter_button_pressed() -> void:
	if filter_line_edit.text == "":
		match current_card_entity:
			CardEntities.animal:
				_on_animal_button_pressed()
			CardEntities.adopter:
				_on_adopter_button_pressed()
			CardEntities.address:
				_on_address_button_pressed()
		return

	match current_card_entity:
		CardEntities.animal:
			_on_animal_button_pressed(Storage.save_file.animals.filter(
				func(animal: Animal):
					return animal.name.containsn(filter_line_edit.text)
					))
		CardEntities.adopter:
			_on_adopter_button_pressed(Storage.save_file.adopter.filter(
				func(adopter: Adopter):
					return adopter.name.containsn(filter_line_edit.text)
					))
		CardEntities.address:
			_on_address_button_pressed(Storage.save_file.address.filter(
				func(address: Address):
					return address.city.containsn(filter_line_edit.text)
					))

func _on_card_edit_adopter(data: Resource) -> void:
	entity_picker_menu.show()
	entity_picker.target_entity = data
	entity_picker.target_sub_entity = entity_picker.SUB_ENTITY.adopter
	entity_picker._setup()

func _on_card_edit_address(data: Resource) -> void:
	entity_picker_menu.show()
	entity_picker.target_entity = data
	entity_picker.target_sub_entity = entity_picker.SUB_ENTITY.address
	entity_picker._setup()

func _on_entity_confirm_button_pressed() -> void:
	entity_picker_menu.hide()
