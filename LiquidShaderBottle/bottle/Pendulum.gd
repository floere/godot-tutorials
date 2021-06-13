extends Position2D

export(float) var length = 30

var end_position : Vector2
var angle : float

export(float) var gravity = 0.4 * 60 # 98
export(float) var damping = 0.995
export(float) var angular_multiplier = 0.0003

var previous_global_position = global_position
var angular_velocity = 0.0
var angular_acceleration = 0.0

func _ready() -> void:
	end_position = global_position + Vector2(length, 0)
	angle = Vector2.ZERO.angle_to(end_position - global_position)
	angular_velocity = 0.0
	angular_acceleration = 0.0

func process_velocity(delta : float) -> void:
	add_angular_velocity((previous_global_position.x - global_position.x) * angular_multiplier)
	# Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
	angular_acceleration = ((-gravity * delta) / length) * sin(angle)
	# Increment velocity.
	angular_velocity += angular_acceleration
	# Arbitrary damping.
	angular_velocity *= damping
	# Increment angle.
	angle += angular_velocity
	
	var global_angle = angle + global_rotation
	
	end_position = global_position + Vector2(length * sin(global_angle), length * cos(global_angle))
	
	# Store previous global position to add angular velocity in the next frame.
	previous_global_position = global_position

func add_angular_velocity(force:float) -> void:
	angular_velocity += force

func _physics_process(delta) -> void:
	process_velocity(delta)
	update() # For the draw.

func _draw() -> void:
	draw_line(Vector2.ZERO, end_position - global_position, Color.black, 1.0, false)
	draw_circle(end_position - global_position, 2.0, Color.red)
