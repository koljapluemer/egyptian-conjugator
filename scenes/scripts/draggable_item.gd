class_name DragItem extends TextureRect
var btn_label

const BTN_LABEL = preload("res://scenes/btnLabel.tscn")
const SLOT_PANEL = preload("res://scenes/slotPanel.tscn")

var original_value

func _init():
	btn_label = BTN_LABEL.instantiate()
	add_child(btn_label)
	var panel = SLOT_PANEL.instantiate()
	add_child(panel)

func set_values(text):
	btn_label.text = text	
	original_value = text

func _get_drag_data(at_position):
	var preview_label = Label.new()
	preview_label.text = btn_label.text
	
	var preview = Control.new()
	preview.add_child(preview_label)
	
	set_drag_preview(preview)
	btn_label.text = ""
	
	return preview_label.text
	
func reset_text():
	btn_label.text = original_value
