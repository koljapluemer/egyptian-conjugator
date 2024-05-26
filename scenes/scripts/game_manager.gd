extends Node2D

const DRAG_SLOT = preload("res://scenes/dragSlot.tscn")
const DRAG_BUTTON = preload("res://scenes/dragButton.tscn")
@onready var green_confetti: CPUParticles2D = $Particles/Confetti/green

@onready var prompt: Label = $Prompt
@onready var combined: Label = $Combined

const EXERCISES_PATH = "res://data/execises.json"
var exercises = []

const BUTTONS = ["ا", "أ", "ت", "ي", "و", "ن"]
const SLOTS = ["", "", "ل", "م", "ع", ""]

var current_exercise_index: int

var slotObjects = []
var buttonObjects = []
var exercise = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# make drag slots
	for i in range(SLOTS.size()):
		var dragSlot = DRAG_SLOT.instantiate()
		var textVal = SLOTS[i]
		dragSlot.set_values(textVal, self)
		dragSlot.position = Vector2(300 + i * 50, 100)
		dragSlot.connect("drag_finished", _on_drag_finished)
		add_child(dragSlot)
		slotObjects.append(dragSlot)
	# make drag buttons
	for i in range(BUTTONS.size()):
		var dragButton = DRAG_BUTTON.instantiate()
		dragButton.set_values(BUTTONS[i])
		dragButton.position = Vector2(300 + i * 50, 200)
		add_child(dragButton)
		buttonObjects.append(dragButton)
	exercises = load_json_file(EXERCISES_PATH)
	set_new_exercise()

func load_json_file(file_path:String):
	if FileAccess.file_exists(file_path):
		var dataFile = FileAccess.open(file_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	else:
		print("File does not exist")


func set_new_exercise() -> void:
	reset_buttons_and_slots()
	# pick a random exercise
	current_exercise_index = randi() % exercises.size()
	exercise = exercises[current_exercise_index]
	prompt.text = exercise["EN"]

func set_combined_label() -> void:
	var combinedText = "= "
	for i in range(slotObjects.size()):
		combinedText += slotObjects[slotObjects.size()-i-1].btn_label.text
	combined.text = combinedText

func reset_buttons_and_slots() -> void:
	for i in range(slotObjects.size()):
		slotObjects[i].reset_text()
	for i in range(buttonObjects.size()):
		buttonObjects[i].reset_text()
	set_combined_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_drag_finished() -> void:
	set_combined_label()
	# check if exercise is solved
	# by looping through slotObjects and checking against exercise.solution
	var solved = true
	for i in range(slotObjects.size()):
		var userSolution = slotObjects[i].btn_label.text
		var correctSolution = exercise.solution[i]
		print("comparing", userSolution, "with", correctSolution, "...")
		if userSolution != correctSolution:
			solved = false
			break
	print("drag finished, correct:", solved)
	# start timer!!!!!!!!!!!!!!!!, after 1 second get new exercise
	if solved:
		green_confetti.emitting = true
		var timer = Timer.new()
		timer.wait_time = 1.0
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()




func _on_timer_timeout() -> void:
	set_new_exercise()
 
func _on_reset_button_pressed() -> void:
	reset_buttons_and_slots()
