extends Node3D
@export var cue: RigidBody3D

var direction = 0

var move_speed = 0.75
var rotate_speed = 1.5


var shots = 0
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
	if cue.flying == false:
		var zvel = (transform.basis.z * forward * move_speed)
		zvel.y = 0
		
		var xvel = (transform.basis.x * side * move_speed)
		xvel.y = 0
		
		var movement = zvel - xvel
		
		global_position += movement * delta
		
		var rot_x = Input.get_axis("rotate_down", "rotate_up")
		var rot_y = Input.get_axis("rotate_left", "rotate_right")
		
		direction += rotation.y * rotate_speed
		global_rotation += -Vector3(rot_x, rot_y, 0) * delta
		
		#from online
		rotation.x = clamp(rotation.x, deg_to_rad(5), deg_to_rad(60))
		
		if Input.is_action_pressed("charge"):
			charge += 100 * delta
			charge = clamp(charge, 0, 50)
			print(charge)
		if Input.is_action_just_released("charge"):
			shoot = true
		
