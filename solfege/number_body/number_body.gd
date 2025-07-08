class_name NumberBody extends CharacterBody2D

signal spawned(number_body: NumberBody)

@export var animated_sprite: AnimatedSprite2D

var number: int
var _velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	spawned.emit(self)

func spawn(num: int, global_pos: Vector2, initial_vel: Vector2 = Vector2.ZERO) -> void:
	number = num
	if number == 0:
		return
	animated_sprite.frame = number - 1
	global_position = global_pos
	_velocity = initial_vel

func _physics_process(delta: float) -> void:
	velocity = _velocity
	move_and_slide()
	_velocity = velocity

func die() -> void:
	var parent: Node = get_parent()
	if parent != null:
		parent.remove_child(self)
	queue_free()
