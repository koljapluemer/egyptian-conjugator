extends Node2D

const DRAG_SLOT = preload("res://scenes/dragSlot.tscn")
const DRAG_BUTTON = preload("res://scenes/dragButton.tscn")

@onready var prompt: Label = $Prompt

const EXERCISES = [
	{
		"prompt": "I work.",
		"solution": ["ل", "م", "ع", "أ"]
	},
	{
		"prompt": "You work. (m)",
		"solution": ["ل", "م", "ع", "ت"]
	},
	{
		"prompt": "You work. (f)",
		"solution": ["ي", "ل", "م", "ع", "ت"]
	},
	{
		"prompt": "He works.",
		"solution": ["ل", "م", "ع", "ي"]
	},
	{
		"prompt": "She works.",
		"solution": ["ل", "م", "ع", "ت"]
	},
	{
		"prompt": "We work.",
		"solution": ["ل", "م", "ع", "ن"]
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pick a random exercise
	current_exercise_index = randi() % EXERCISES.size()
	var exercise = EXERCISES[current_exercise_index]
	prompt.text = exercise.prompt
	# make drag slots
	for i in range(SLOTS.size()):
		var dragSlot = DRAG_SLOT.instantiate()
		var textVal = SLOTS[i]
		print("drag slot with val", textVal, "for instance", dragSlot)
		dragSlot.set_values(textVal)
		dragSlot.position = Vector2(300 + i * 50, 100)
		add_child(dragSlot)
	# make drag buttons
	for i in range(BUTTONS.size()):
		var dragButton = DRAG_BUTTON.instantiate()
		dragButton.set_values(BUTTONS[i])
		dragButton.position = Vector2(300 + i * 50, 200)
		add_child(dragButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
