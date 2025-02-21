extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
@onready var name_label: Label = %NameLabel
@onready var sex_label: Label = %SexLabel
@onready var size_label: Label = %SizeLabel
@export var data: Resource:
	set(new_data):
		data = new_data
		if data != null:
			_set_values.call_deferred()

var have_mouse_focus: bool = false

func _ready() -> void:
	data.changed.connect(_set_values)

func _set_values() -> void:
	if data is Animal:
		texture_rect.show()
		texture_rect.texture = data.image
		name_label.text = data.name
		match data.Sex:
			0: sex_label.text = "Male"
			1: sex_label.text = "Female"
		match data.Size:
			0: size_label.text = "Small"
			1: size_label.text = "Medium"
			2: size_label.text = "Big"
			3: size_label.text = "Extra Big"
	elif data is Adopter:
		texture_rect.hide()
		name_label.text = data.name
		sex_label.text = data.telephone_number
		size_label.text = ""
	elif data is Address:
		texture_rect.hide()
		name_label.text = data.city
		sex_label.text = data.street_name
		size_label.text = str(data.street_number)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and have_mouse_focus:
		if event.is_pressed():
			GlobalSignals.card_pressed.emit(data)

func _on_mouse_exited() -> void:
	have_mouse_focus = false

func _on_mouse_entered() -> void:
	have_mouse_focus = true
