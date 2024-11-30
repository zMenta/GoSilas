extends PanelContainer

@onready var button_insert: Button = %ButtonInsert
@onready var button_remove: Button = %ButtonRemove
@onready var entity_line: HBoxContainer = %EntityLine

@export var is_remove_mode: bool = false:
	set(new_value):
		is_remove_mode = new_value
		_set_mode()

@export var data: Resource:
	set(new_entity):
		data = new_entity
		if entity_line != null:
			entity_line.data = new_entity


func _ready() -> void:
	_set_mode.call_deferred()
	entity_line.data = self.data


func _set_mode() -> void:
	if button_insert == null or button_remove == null:
		return

	if is_remove_mode == true:
		button_remove.show()
		button_insert.hide()
	else:
		button_remove.hide()
		button_insert.show()
