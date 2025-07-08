class_name Boundary extends Area2D

signal number_body_crossed(number: NumberBody)

func _ready() -> void:
	body_entered.connect(_on_boundary_body_entered)

func _on_boundary_body_entered(body: Node2D) -> void:
	if body is NumberBody:
		number_body_crossed.emit(body)
