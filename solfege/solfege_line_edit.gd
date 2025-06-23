class_name SolfegeLineEdit extends LineEdit

signal finished(number: int)

var solfeges: Dictionary[int, String] = {}

func _ready() -> void:
	text_changed.connect(_on_text_changed)

func init(solfeges: Dictionary[int, String]) -> void:
	self.solfeges = solfeges
	text = ""

func _on_text_changed(new_text: String) -> void:
	var number = solfeges.find_key(new_text)
	if number != null:
		number = int(number)
		finished.emit(number)
		text = ""
