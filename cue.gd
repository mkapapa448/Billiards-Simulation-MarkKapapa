extends RigidBody3D
var is_frozen = true
var direction = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var forward = Input.get_axis("move_backward", "move_forward")
	var side = Input.get_axis("move_left", "move_right")
	
	var zmove = (transform.basis.z * forward)
	zmove.y = 0
	
	var xmove = (transform.basis.x * side)
	xmove.y = 0
	var movement = zmove - xmove
	
	position += movement * delta
	
	var rot_x = Input.get_axis("rotate_down", "rotate_up")
	var rot_y = Input.get_axis("rotate_left", "rotate_right")
	
	direction += rotation.y
	rotation += -Vector3(rot_x, rot_y, 0) * delta
	
	#from online
	rotation.x = clamp(rotation.x, deg_to_rad(0), deg_to_rad(30))
