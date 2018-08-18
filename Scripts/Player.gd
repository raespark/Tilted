extends KinematicBody2D

signal color_change_needed

# The force pulling player down towards the ground
const GRAVITY = 3000
# How much force player has to jump
const JUMP_FORCE = -1300
# How much to rotate each frame
const ROTATION_SPEED = .15
# How much to move per frame
const MOVEMENT_SPEED = 800
# How how to float when freeze rotating
const FLOAT_HEIGHT = 75

# players current movemtn/motion
var velocity = Vector2()
# If player is currently rotating
var is_rotating = false
#current rotation
var rotation_degree = 0
# current direction player is going
var direction = 1

func _ready():
	print(globalVars)

func _rotate():
	rotation_degree += direction * ROTATION_SPEED
	if abs(rotation_degree) > (PI/2):
		is_rotating = false
		rotation_degree = direction * (PI/2) #90 degrees
		self.rotation = rotation_degree
		rotation_degree = 0
		set_collision_layer_bit(globalVars.color_index, 0)
		set_collision_mask_bit(globalVars.color_index, 0)
		globalVars.color_index = (4 + globalVars.color_index + direction) % 4
		set_collision_layer_bit(globalVars.color_index, 1)		
		set_collision_mask_bit(globalVars.color_index, 1)
		emit_signal("color_change_needed")
		return
	self.rotation = rotation_degree

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	var friction = false
	if is_rotating:
		_rotate()
	elif Input.is_action_just_pressed("ui_left"):
		direction = -1
		is_rotating = true
		velocity.x += direction * MOVEMENT_SPEED
	elif Input.is_action_just_pressed("ui_right"):
		direction = 1
		is_rotating = true
		velocity.x += direction * MOVEMENT_SPEED
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE
	# The second parameter of move_and_slide is the normal pointing up.
	velocity = move_and_slide(velocity, Vector2(0,-1))
	if is_on_floor():
		# Lerp x down to 0 30% per frame to not have him immediately stop
		velocity.x = lerp(velocity.x, 0, 0.2)
	elif not is_on_floor():
		# lower friction in the air
		velocity.x = lerp(velocity.x, 0, 0.1)