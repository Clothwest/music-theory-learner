class_name Solfege extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var number_body_spawner: NumberBodySpawner = $NumberBodySpawner
@onready var timer_label: TimerLabel = $Timer
@onready var word: Word = $Word
@onready var boundary: Boundary = $Boundary

enum Mode { NORMAL, HARD }

@export var initial_mode: Mode = Mode.NORMAL
var current_mode: Mode = Mode.NORMAL:
	set(c):
		current_mode = c
		number_body_spawner.current_mode = current_mode
@export var threshold: int = 10
var completed_count: int = 0
# hard mode
var delay: float = 0.5
var max: int = 3:
	get():
		if max < 1:
			return 1
		return max

func _ready() -> void:
	# signal
	word.number_found.connect(_on_word_number_found)
	boundary.number_body_entered.connect(_on_boundary_number_body_entered)
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
	var status_code: int = number_body_spawner.kill_by_number(number)
	if status_code != 0:
		return
	word.show_word()
	completed_count += 1
	match current_mode:
		Mode.NORMAL:
			if completed_count >= threshold:
				change_mode_to(Mode.HARD)
				timer_label.visible = false
				boundary.line.visible = true
				word.change_position()
				for n in range(max - 1):
					await spawn_after_delay(delay)
			else:
				reset_after_delay(0.5)
	spawn_after_delay(delay)

func _on_boundary_number_body_entered(number_body: NumberBody) -> void:
	var status_code: int = number_body_spawner.kill_by_number_body(number_body)
	if status_code != 0:
		return
	spawn_after_delay(delay)

func spawn_after_delay(second: float) -> void:
	await get_tree().create_timer(second).timeout
	number_body_spawner.spawn()
