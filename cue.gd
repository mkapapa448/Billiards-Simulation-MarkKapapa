extends RigidBody3D
var direction = 0

var charge = 0.0
var shoot = false
var shooting = false
var pending_shot = false
var flying = false
var reset = false
var original_position = position
var original_rotation = rotation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var forward = Input.get_axis("move_backward", "move_forward")
	var side = Input.get_axis("move_left", "move_right")
	
	var zvel = (transform.basis.z * forward)
	zvel.y = 0
	
	var xvel = (transform.basis.x * side)
	xvel.y = 0
	
	var movement = zvel - xvel
	
	global_position += movement * delta
	
	var rot_x = Input.get_axis("rotate_down", "rotate_up")
	var rot_y = Input.get_axis("rotate_left", "rotate_right")
	
	direction += rotation.y
	global_rotation += -Vector3(rot_x, rot_y, 0) * delta
	
	#from online
	rotation.x = clamp(rotation.x, deg_to_rad(0), deg_to_rad(60))
	
	if Input.is_action_pressed("charge"):
		charge += 200 * delta
		print(charge)
	if Input.is_action_just_released("charge"):
		shoot = true
	
	if shoot == true:
		# Get the local forward/backward Z axis direction
		var z_direction = global_transform.basis.z
		original_position = position
		original_rotation = rotation    
		flying = true
		# Apply continuous force along the object's Z axis
		apply_central_force(z_direction * charge)
		
		charge = 0
		shoot = false
	elif flying == false and reset == true:
		position = original_position
		rotation = original_rotation
		linear_velocity = Vector3.ZERO   # Use Vector2.ZERO for 2D
		angular_velocity = Vector3.ZERO  # Clears any spinning/rotation speed
		reset = false
		

func _on_body_exited(body: Node) -> void:
	flying = false
	reset = true
