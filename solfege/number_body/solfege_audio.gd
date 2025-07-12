class_name SolfegeAudio extends AudioStreamPlayer

const DO: AudioStream = preload("res://assets/solfege/do.wav")
const RE: AudioStream = preload("res://assets/solfege/re.wav")
const MI: AudioStream = preload("res://assets/solfege/mi.wav")
const FA: AudioStream = preload("res://assets/solfege/fa.wav")
const SOL: AudioStream = preload("res://assets/solfege/sol.wav")
const LA: AudioStream = preload("res://assets/solfege/la.wav")
const SI: AudioStream = preload("res://assets/solfege/si.wav")

var solfege: Dictionary[int, AudioStream] = {1: DO, 2: RE, 3: MI, 4: FA, 5: SOL, 6: LA, 7: SI}

func set_audio(number: int) -> void:
	if solfege.has(number):
		stream = solfege[number]

func play_audio() -> void:
	if stream == null:
		return
	play()
	await finished
