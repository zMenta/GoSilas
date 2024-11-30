extends PanelContainer

const entity_card: PackedScene = preload("res://scenes/entity_picker_card.tscn")
enum SUB_ENTITY {adopter, animal, address}

@onready var entity_linked_label: Label = %EntityLinkedLabel
@onready var entity_available_label: Label = %EntityAvailableLabel
@onready var entity_linked_container: VBoxContainer = %LinkedContainer
@onready var entity_available_container: VBoxContainer = %AvailableContainer

@export var target_sub_entity: SUB_ENTITY
@export var target_entity: Resource


func _ready() -> void:
	_setup()


func _setup() -> void:
	for child in entity_available_container.get_children():
		child.queue_free()
	for child in entity_linked_container.get_children():
		child.queue_free()

	match target_sub_entity:
		SUB_ENTITY.adopter:
			entity_linked_label.text = "Adotante Vinculado"
			entity_available_label.text = "Adotantes"

			target_entity = target_entity as Animal
			for adopter: Adopter in Storage.save_file.adopter:
				if adopter != target_entity.adopter:
					var card := entity_card.instantiate()
					card.data = adopter
					entity_available_container.add_child(card)

			var card_linked := entity_card.instantiate()
			card_linked.data = target_entity.adopter
			card_linked.is_remove_mode = true
			entity_linked_container.add_child(card_linked)


		SUB_ENTITY.animal:
			pass
		SUB_ENTITY.address:
			pass
