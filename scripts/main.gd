extends PanelContainer

@onready var card_container : HFlowContainer = %CardContainer

const CARD: PackedScene = preload("res://scenes/card.tscn")

func _on_add_button_pressed() -> void:
	var card := CARD.instantiate()
	card_container.add_child(card)
