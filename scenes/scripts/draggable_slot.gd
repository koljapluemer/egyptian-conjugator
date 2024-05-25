class_name DragSlot extends TextureRect

const BTN_LABEL = preload("res://scenes/btnLabel.tscn")
const SLOT_PANEL = preload("res://scenes/slotPanel.tscn")

var original_value = "X"
var btn_label

func _init() -> void:
	btn_label = BTN_LABEL.instantiate()
	add_child(btn_label)
	var panel = SLOT_PANEL.instantiate()
	add_child(panel)
	print("made new drag slot")

func set_values(text):
	print("setting value to", text)
	original_value = text	
	btn_label.text = text		

func _can_drop_data(at_position, data):
	return true
	
func _drop_data(at_position, data):
	btn_label.text = data

func _input(event: InputEvent) -> void:
	# on mouseclick, reset to original value (but only instance)
	if Input.is_action_just_pressed("left_click"):
		btn_label.text = original_value
