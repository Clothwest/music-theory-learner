class_name Solfege extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var number_body_spawner: NumberBodySpawner = $NumberBodySpawner
@onready var timer_label: TimerLabel = $Timer
@onready var solfege_line_edit: SolfegeLineEdit = $Solfege

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
	solfege_line_edit.number_found.connect(_on_solfege_line_edit_number_found)
	#
	change_mode_to(initial_mode)
	#
	number_body_spawner.init(initial_mode)
	timer_label.init()
	solfege_line_edit.init()
	#
	call_deferred("on_ready")
	#
	number_body_spawner.spawn()

func on_ready() -> void:
	solfege_line_edit.grab_focus()

func change_mode_to(mode: Mode) -> void:
	current_mode = mode
	animated_sprite.frame = current_mode

func reset() -> void:
	timer_label.reset()
	solfege_line_edit.reset()

func _on_solfege_line_edit_number_found(number: int) -> void:
	var status_code: int = number_body_spawner.kill(number)
	if status_code != 0:
		solfege_line_edit.reset()
		return
	completed_count += 1
	if current_mode != Mode.HARD and completed_count >= threshold:
		change_mode_to(Mode.HARD)
		timer_label.visible = false
		for n in range(2):
			await spawn_in_delay(0.5)
	#
	solfege_line_edit.reset()
	timer_label.reset()
	spawn_in_delay(0.5)

func spawn_in_delay(second: float) -> void:
	await get_tree().create_timer(second).timeout
	number_body_spawner.spawn()
