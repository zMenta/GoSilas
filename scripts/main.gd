extends PanelContainer

@onready var card_container : HFlowContainer = %CardContainer
@onready var left_container : MarginContainer = %LeftContainer
@onready var main_split_container : HSplitContainer = %MainSplitContainer

const CARD: PackedScene = preload("res://scenes/card.tscn")

func _on_add_button_pressed() -> void:
	var card := CARD.instantiate()
	card_container.add_child(card)

# Debug button
func _on_button_7_pressed() -> void:
	_on_card_details_closed_button_pressed()

func _on_card_details_closed_button_pressed() -> void:
	left_container.visible = !left_container.visible

	if left_container.visible == true:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_VISIBLE
	else:
		main_split_container.dragger_visibility = main_split_container.DraggerVisibility.DRAGGER_HIDDEN_COLLAPSED

# func _ready() -> void:
# 	Storage.data = SaveFile.new()
# 	for i in range(200000):
# 		var adop = Adopter.new()
# 		var animal = Animal.new()
# 		animal.is_castrated = false
# 		animal.Sex = 2
# 		animal.adopter = adop
# 		Storage.data.animals.append(animal)
