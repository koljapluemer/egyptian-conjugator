extends TextureRect
@onready var btn_label: Label = $"BtnLabel"


func _get_drag_data(at_position):
	var preview_label = Label.new()
	preview_label.text = btn_label.text
	
	var preview = Control.new()
	preview.add_child(preview_label)
	#preview_label.position = Vector2(0, 0)
	#preview.position = Vector2(0, 0)
	
	set_drag_preview(preview)
	btn_label.text = ""
	
	return preview_label.text

