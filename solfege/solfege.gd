class_name Solfege extends Control

@onready var timer_label: TimerLabel = %Timer
@onready var number_label: Label = %Number
@onready var solfege_line_edit: SolfegeLineEdit = %Solfege

# numbers and solfeges
var numbers: Array = [1, 2, 3, 4, 5, 6, 7]
var solfeges: Dictionary[int, String] = {1: "do", 2: "re", 3: "mi", 4: "fa", 5: "sol", 6: "la", 7: "si"}

#
#var finished: bool = false

func _ready() -> void:
	# signal
	solfege_line_edit.finished.connect(_on_solfege_line_edit_finished)
	#
	timer_label.init()
	number_label.text = str(numbers.pick_random())
	solfege_line_edit.init(solfeges)
	call_deferred("on_ready")
	

func on_ready() -> void:
	solfege_line_edit.grab_focus()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_solfege_line_edit_finished(number: int) -> void:
	timer_label.reset()
	number_label.text = str(numbers.pick_random())
