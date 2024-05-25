extends Node2D

const DRAG_SLOT = preload("res://scenes/dragSlot.tscn")
const DRAG_BUTTON = preload("res://scenes/dragButton.tscn")

@onready var prompt: Label = $Prompt

const EXERCISES = [
	{
		"prompt": "I work.",
		"solution": ["", "", "ل", "م", "ع", "أ"]
	},
	{
		"prompt": "You work. (m)",
		"solution": ["", "", "ل", "م", "ع", "ت"]
	},
	{
		"prompt": "You work. (f)",
		"solution": ["", "", "ي", "ل", "م", "ع", "ت"]
	},
	{
		"prompt": "He works.",
		"solution": ["", "", "ل", "م", "ع", "ي"]
	},
	{
		"prompt": "She works.",
		"solution": ["", "", "ل", "م", "ع", "ت"]
	},
	{
		"prompt": "We work.",
		"solution": ["", "", "ل", "م", "ع", "ن"]
	},
	{
		"prompt": "You work. (pl)",
		"solution": ["ا", "و", "ل", "م", "ع", "ت"]
	},
	{
		"prompt": "They work.",
		"solution": ["ا", "و", "ل", "م", "ع", "ي"]

	}
]

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

	set_new_exercise()

func set_new_exercise() -> void:
	reset_buttons_and_slots()
	# pick a random exercise
	current_exercise_index = randi() % EXERCISES.size()
	exercise = EXERCISES[current_exercise_index]
	prompt.text = exercise.prompt

func reset_buttons_and_slots() -> void:
	for i in range(slotObjects.size()):
		slotObjects[i].reset_text()
	for i in range(buttonObjects.size()):
		buttonObjects[i].reset_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_drag_finished() -> void:
	# check if exercise is solved
	# by looping through slotObjects and checking against exercise.solution
	var solved = true
	for i in range(slotObjects.size()):
		var userSolution = slotObjects[i].btn_label.text
		var correctSolution = exercise.solution[i]
		print("comparing", userSolution, correctSolution)
		if userSolution != correctSolution:
			solved = false
			break
	print("drag finished, correct:", solved)
	# start timer!!!!!!!!!!!!!!!!, after 1 second get new exercise
	if solved:
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
