extends PanelContainer

@onready var name_label : Label = %NameLabel
@onready var sex_label : Label = %SexLabel
@onready var size_label: Label = %SizeLabel

@export var data: Animal :
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()

func _set_values() -> void:
	name_label.text = data.name
	match data.Sex:
		0: sex_label.text = "Male"
		1: sex_label.text = "Female"
	match data.Size:
		0: size_label.text = "Small"
		1: size_label.text = "Medium"
		2: size_label.text = "Big"
		3: size_label.text = "Extra Big"
