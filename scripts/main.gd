extends PanelContainer

@onready var card_container : HFlowContainer = %CardContainer
@onready var left_container : MarginContainer = %LeftContainer
@onready var main_split_container : HSplitContainer = %MainSplitContainer
@onready var create_card : PanelContainer = %CreateCard
@onready var details_card : PanelContainer = %CardDetails
# @onready var resource_picker : PopupPanel = %ResourcePickerMenu

const CARD: PackedScene = preload("res://scenes/card.tscn")

func _on_add_button_pressed() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	create_card.show()
	left_container.show()

# Debug button
func _on_button_7_pressed() -> void:
	_on_card_details_closed_button_pressed()
	# resource_picker.popup()

func _on_card_details_closed_button_pressed() -> void:
	details_card.show()
	left_container.visible = !left_container.visible
	if left_container.visible == true:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_VISIBLE
	else:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_HIDDEN_COLLAPSED

func _on_create_card_create_card_cancel_pressed() -> void:
	for child:Control in left_container.get_children():
		child.hide()
	left_container.hide()

func _on_create_card_animal_created(animal: Animal) -> void:
	var card := CARD.instantiate()
	card.data = animal
	card_container.add_child(card)
