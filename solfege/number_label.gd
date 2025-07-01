class_name NumberLabel extends Label

var numbers: Array[int] = [1, 2, 3, 4, 5, 6, 7]
var number: int = 0
var number_history: Array[int]
var history_length: int = 2

func init() -> void:
	reset()

func reset() -> void:
	randomize_number_by_history()
	text = str(number)

func randomize_number_by_history() -> void:
	var new_numbers: Array[int] = numbers.filter(func(n): return not number_history.has(n))
	number = new_numbers.pick_random()
	number_history.push_back(number)
	if number_history.size() > history_length:
		number_history.pop_front()
