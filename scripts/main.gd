extends PanelContainer

@onready var file_dialog: FileDialog = %FileDialog
@onready var card_container : HFlowContainer = %CardContainer
@onready var left_container : MarginContainer = %LeftContainer
@onready var main_split_container : HSplitContainer = %MainSplitContainer
@onready var create_card : PanelContainer = %CreateCard
@onready var details_card : PanelContainer = %CardDetails
# @onready var resource_picker : PopupPanel = %ResourcePickerMenu

const CARD: PackedScene = preload("res://scenes/card.tscn")

func _ready() -> void:
	details_card.file_dialog = file_dialog
	create_card.file_dialog = file_dialog
	GlobalSignals.card_pressed.connect(_on_card_pressed)
	_on_animal_button_pressed()

func _on_add_button_pressed() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	create_card.show()
	left_container.show()
	_check_dragger_visibility()

func show_card_details() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	details_card.show()
	left_container.show()
	_check_dragger_visibility()

func _check_dragger_visibility() -> void:
	if left_container.visible == true:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_VISIBLE
	else:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_HIDDEN_COLLAPSED

func _on_card_details_closed_button_pressed() -> void:
	details_card.show()
	left_container.visible = !left_container.visible
	_check_dragger_visibility()

func _on_create_card_create_card_cancel_pressed() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	left_container.hide()
	_check_dragger_visibility()

func _on_create_card_animal_created(animal: Animal) -> void:
	var card := CARD.instantiate()
	card.data = animal
	card_container.add_child(card)

func _on_card_pressed(data: Resource) -> void:
	show_card_details()
	details_card.data = data

func _clear_card_container() -> void:
	for child in card_container.get_children():
		child.queue_free()

func _on_address_button_pressed() -> void:
	_clear_card_container()
	for address in Storage.save_file.address:
		var card := CARD.instantiate()
		card.data = address
		card_container.add_child(card)

func _on_adopter_button_pressed() -> void:
	_clear_card_container()
	for adopter in Storage.save_file.adopter:
		var card := CARD.instantiate()
		card.data = adopter
		card_container.add_child(card)

func _on_animal_button_pressed() -> void:
	_clear_card_container()
	for animal in Storage.save_file.animals:
		var card := CARD.instantiate()
		card.data = animal
		card_container.add_child(card)
