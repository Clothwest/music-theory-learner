class_name SolfegeLineEdit extends LineEdit

signal number_found(number: int)

var solfeges: Dictionary[int, String] = {1: "do", 2: "re", 3: "mi", 4: "fa", 5: "sol", 6: "la", 7: "si"}

func _ready() -> void:
	# signal
	text_changed.connect(_on_text_changed)
	#
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	pivot_offset = size / 2

func init() -> void:
	reset()

func reset() -> void:
	text = ""

func _on_text_changed(new_text: String) -> void:
	if new_text.length() > 3:
		reset()
		return
	var number = solfeges.find_key(new_text)
	if number != null:
		number = int(number)
		number_found.emit(number)
