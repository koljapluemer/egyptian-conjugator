extends TextureRect
@onready var btn_label: Label = $"BtnLabel"
	
func _can_drop_data(at_position, data):
	return true
	
func _drop_data(at_position, data):
	btn_label.text = data
