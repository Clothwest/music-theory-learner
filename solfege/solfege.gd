class_name Solfege extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var number_body_spawner: NumberBodySpawner = $NumberBodySpawner
@onready var timer_label: TimerLabel = $Timer
@onready var word: Word = $Word

enum Mode { NORMAL, HARD }

@export var initial_mode: Mode = Mode.NORMAL
var current_mode: Mode = Mode.NORMAL:
	set(c):
		current_mode = c
		number_body_spawner.current_mode = current_mode
@export var threshold: int = 10
var completed_count: int = 0

func _ready() -> void:
	# signal
	word.number_found.connect(_on_word_number_found)
	#
	change_mode_to(initial_mode)
	#
	number_body_spawner.init(initial_mode)
	timer_label.init()
	#
	number_body_spawner.spawn()

func change_mode_to(mode: Mode) -> void:
	current_mode = mode
	animated_sprite.frame = current_mode

func reset() -> void:
	timer_label.reset()
	word.reset()

func reset_after_delay(second: float) -> void:
	await get_tree().create_timer(second).timeout
	reset()

func _on_word_number_found(number: int) -> void:
	var status_code: int = number_body_spawner.kill(number)
	if status_code != 0:
		return
	word.show_word()
	completed_count += 1
	match current_mode:
		Mode.NORMAL:
			if completed_count >= threshold:
				change_mode_to(Mode.HARD)
				timer_label.visible = false
				for n in range(2):
					await spawn_after_delay(0.5)
			else:
				reset_after_delay(0.5)
	spawn_after_delay(0.5)

func spawn_after_delay(second: float) -> void:
	await get_tree().create_timer(second).timeout
	number_body_spawner.spawn()
