class_name Word extends Node2D

signal number_found(number: int)

@onready var label: Label = $Label

var map: Dictionary[String, int] = {"do": 1, "re": 2, "mi": 3, "fa": 4, "sol": 5, "la": 6, "si": 7}
#
var inputs: Array[String] = []
var word: String

func _ready() -> void:
	position = get_viewport().get_visible_rect().size / 2

func _unhandled_key_input(event: InputEvent) -> void:
	event = event as InputEventKey
	if is_key_just_pressed(event):
		inputs.push_back(event.as_text_keycode().to_lower())
		if inputs.size() > 3:
			inputs.pop_front()
		var input_word: String = "sol" if inputs.size() >= 3 and inputs[-3] + inputs[-2] + inputs[-1] == "sol" else (inputs[-2] + inputs[-1]) if inputs.size() >= 2 else ""
		if map.has(input_word):
			inputs.clear()
			word = input_word
			number_found.emit(map[word])

func change_position(pos:Vector2 = Vector2(800.0, 30.0)) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position", pos, 1)

func show_word() -> void:
	label.text = word

func reset() -> void:
	label.text = ""

func is_key_just_pressed(event: InputEventKey) -> bool:
	if event.pressed and not event.echo:
		return true
	return false
