extends Node2D

onready var liquid = $Sprite/Liquid

var t = 0

func _ready() -> void:
	position.y = 200
	pass

func _physics_process(delta: float) -> void:
	t += delta
	position.x = 400 + 200 * sin(2 * t)
	pass
