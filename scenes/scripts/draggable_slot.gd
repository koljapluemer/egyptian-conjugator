class_name DragSlot extends TextureRect

const BTN_LABEL = preload("res://scenes/btnLabel.tscn")
const SLOT_PANEL = preload("res://scenes/slotPanel.tscn")

var original_value = "X"
var btn_label

signal drag_finished

func _init() -> void:
	btn_label = BTN_LABEL.instantiate()
	add_child(btn_label)
	var panel = SLOT_PANEL.instantiate()
	add_child(panel)

func set_values(text, parent):
	original_value = text	
	btn_label.text = text		

func reset_text():
	btn_label.text = original_value

func _can_drop_data(at_position, data):
	return true
	
func _drop_data(at_position, data):
	btn_label.text = data
	drag_finished.emit()

