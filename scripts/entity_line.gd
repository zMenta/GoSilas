extends HBoxContainer
class_name EntityLine

@onready var label1: Label = %Label1
@onready var label2: Label = %Label2
@onready var label3: Label = %Label3
@export var data: Resource:
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()

func _ready() -> void:
	data.changed.connect(_set_values)

func _set_values() -> void:
	if data is Animal:
		label1.text = data.name
		match data.Sex:
			0: label2.text = "Male"
			1: label2.text = "Female"
		match data.Size:
			0: label3.text = "Small"
			1: label3.text = "Medium"
			2: label3.text = "Big"
			3: label3.text = "Extra Big"
	elif data is Adopter:
		label1.text = data.name
		label2.text = data.telephone_number
		label3.text = ""
	elif data is Address:
		label1.text = data.city
		label2.text = data.street_name
		label3.text = str(data.street_number)
