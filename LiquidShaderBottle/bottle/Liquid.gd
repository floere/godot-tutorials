extends Sprite

onready var pendulum = $Pendulum

func _physics_process(_delta: float) -> void:
	material.set_shader_param('EdgeRotation', - pendulum.angle - global_rotation)
