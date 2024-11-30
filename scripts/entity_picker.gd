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
	GlobalSignals.entity_picker_remove_button_pressed.connect(_on_card_remove_pressed)
	GlobalSignals.entity_picker_insert_button_pressed.connect(_on_card_insert_pressed)
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

			if target_entity.adopter != null:
				var card_linked := entity_card.instantiate()
				card_linked.data = target_entity.adopter
				card_linked.is_remove_mode = true
				entity_linked_container.add_child(card_linked)

		SUB_ENTITY.animal:
			entity_linked_label.text = "Animais Vinculados"
			entity_available_label.text = "Animais"

			target_entity = target_entity as Adopter
			for animal: Animal in Storage.save_file.animals:
				if !target_entity.adopted_animals.find(animal):
					var card := entity_card.instantiate()
					card.data = animal
					entity_available_container.add_child(card)

			for animal in target_entity.adopted_animals:
				var card_linked := entity_card.instantiate()
				card_linked.data = animal
				card_linked.is_remove_mode = true
				entity_linked_container.add_child(card_linked)

		SUB_ENTITY.address:
			entity_linked_label.text = "Endereço Vinculado"
			entity_available_label.text = "Endereços"

			target_entity = target_entity as Animal
			for address: Address in Storage.save_file.address:
				if address != target_entity.address:
					var card := entity_card.instantiate()
					card.data = address
					entity_available_container.add_child(card)

			if target_entity.address != null:
				var card_linked := entity_card.instantiate()
				card_linked.data = target_entity.address
				card_linked.is_remove_mode = true
				entity_linked_container.add_child(card_linked)


func _on_card_insert_pressed(data: Resource) -> void:
	match target_sub_entity:
		SUB_ENTITY.adopter:
			target_entity.adopter = data
			_setup()
		SUB_ENTITY.animal:
			target_entity.adopted_animals.append(data)
			_setup()
		SUB_ENTITY.address:
			target_entity.address = data
			_setup()

func _on_card_remove_pressed(data: Resource) -> void:
	match target_sub_entity:
		SUB_ENTITY.adopter:
			target_entity.adopter = null
			_setup()
		SUB_ENTITY.animal:
			target_entity.adopted_animals.erase(data)
			_setup()
		SUB_ENTITY.address:
			target_entity.address = null
			_setup()

func _on_confirm_button_pressed() -> void:
	GlobalSignals.entity_picker_confirm_pressed.emit()
