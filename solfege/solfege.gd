class_name Solfege extends Control

@onready var timer_label: TimerLabel = %Timer
@onready var number_label: NumberLabel = %Number
@onready var solfege_line_edit: SolfegeLineEdit = %Solfege

func _ready() -> void:
	# signal
	solfege_line_edit.number_found.connect(_on_solfege_line_edit_number_found)
	#
	number_label.init()
	timer_label.init()
	solfege_line_edit.init()
	call_deferred("on_ready")

func on_ready() -> void:
	solfege_line_edit.grab_focus()

func reset() -> void:
	number_label.reset()
	timer_label.reset()
	solfege_line_edit.reset()

func _on_solfege_line_edit_number_found(number: int) -> void:
	if number == number_label.number:
		timer_label.timer_ticked = false
		await get_tree().create_timer(0.5).timeout
		reset()
