class_name NumberBodySpawner extends Node

const NUMBER_BODY: PackedScene = preload("res://solfege/number_body/number_body.tscn")

var viewport_center_position: Vector2
#
var numbers: Array[int] = [1, 2, 3, 4 ,5, 6, 7]
var positions: Array[Vector2] = []
var velocities: Array[Vector2] = [Vector2(100.0, 0.0), Vector2(125.0, 0.0), Vector2(150.0, 0.0)]
#var velocities: Array[Vector2] = [Vector2.ZERO]
#
var current_mode: Solfege.Mode = Solfege.Mode.NORMAL
#
var killable_number_bodies: Array[NumberBody] = []
var killable_numbers: Array[int] = []

func _ready() -> void:
	viewport_center_position = get_viewport().get_visible_rect().size / 2
	#
	var x: float = get_viewport().get_visible_rect().size.x / 10
	var y: float = get_viewport().get_visible_rect().size.y / 4
	positions.push_back(Vector2(x, y * 1))
	positions.push_back(Vector2(x, y * 2))
	positions.push_back(Vector2(x, y * 3))

func init(initial_mode: Solfege.Mode) -> void:
	current_mode = initial_mode

func spawn() -> void:
	match current_mode:
		Solfege.Mode.NORMAL:
			spawn_normal()
		Solfege.Mode.HARD:
			spawn_hard()
		_:
			return

func spawn_normal() -> void:
	var number_body = NUMBER_BODY.instantiate()
	number_body.spawned.connect(_on_number_body_spawned)
	var number = numbers.pick_random()
	number_body.spawn(number, viewport_center_position)
	add_child(number_body)

func spawn_hard() -> void:
	var number_body = NUMBER_BODY.instantiate()
	number_body.spawned.connect(_on_number_body_spawned)
	var num = numbers.pick_random()
	var pos = positions.pick_random()
	var vel = velocities.pick_random()
	number_body.spawn(num, pos, vel)
	add_child(number_body)

func kill_by_number(number: int) -> int:
	var index: int = killable_numbers.find(number)
	if index < 0:
		return 1
	var number_body: NumberBody = killable_number_bodies[index]
	killable_number_bodies.remove_at(index)
	killable_numbers.remove_at(index)
	number_body.die()
	return 0

func kill_by_number_body(number_body: NumberBody) -> int:
	var index: int = killable_number_bodies.find(number_body)
	if index < 0:
		return 1
	killable_number_bodies.remove_at(index)
	killable_numbers.remove_at(index)
	number_body.die()
	return 0

func _on_number_body_spawned(number_body: NumberBody) -> void:
	killable_number_bodies.push_back(number_body)
	killable_numbers.push_back(number_body.number)
