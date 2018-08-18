extends KinematicBody2D

signal color_change_needed

# The force pulling player down towards the ground
const GRAVITY = 3000
# How much force player has to jump
const JUMP_FORCE = -1600
# How much to rotate each frame
const ROTATION_SPEED = .2
# How much to move per frame
const MOVEMENT_SPEED = 800
# How how to float when freeze rotating
const FLOAT_HEIGHT = 75

# players current movemtn/motion
var velocity = Vector2()
# If player is currently rotating
var is_rotating = false
# If character is currently in the air
var is_in_air = false
#current rotation
var rotation_degree = 0
# current direction player is going
var direction = 1
# If currently in a freeze frame
var frozen

func _ready():
	print(globalVars)

func _freeze_frame():
	frozen = true

func _unfreeze():
	frozen = false
	emit_signal("color_change_needed")

func _rotate():
	rotation_degree += direction * ROTATION_SPEED
	if abs(rotation_degree) > 1.57079633:
		is_rotating = false
		rotation_degree = direction * 1.57079633 #90 degrees
		self.rotation = rotation_degree
		rotation_degree = 0
		globalVars.color_index = (globalVars.color_index + direction) % 4
		if is_on_floor() and not frozen:
			emit_signal("color_change_needed")
		return
	self.rotation = rotation_degree

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	var friction = false
	if is_rotating:
		_rotate()
	elif Input.is_action_just_pressed("ui_select"):
		position = Vector2(position.x, position.y - FLOAT_HEIGHT)
		_freeze_frame()
	elif Input.is_action_just_released("ui_select"):
		position = Vector2(position.x, position.y + FLOAT_HEIGHT)
		_unfreeze()
	elif Input.is_action_just_pressed("ui_left"):
		direction = -1
		is_rotating = true
		if not frozen:
			velocity.x += direction * MOVEMENT_SPEED
	elif Input.is_action_just_pressed("ui_right"):
		direction = 1
		is_rotating = true
		if not frozen:
			velocity.x += direction * MOVEMENT_SPEED
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE
	if not frozen:
		# The second parameter of move_and_slide is the normal pointing up.
		velocity = move_and_slide(velocity, Vector2(0,-1))
		if is_on_floor():
			# Lerp x down to 0 30% per frame to not have him immediately stop
			velocity.x = lerp(velocity.x, 0, 0.2)
			if is_in_air:
				#just landed
				emit_signal("color_change_needed")
				is_in_air = false
		elif not is_on_floor():
			# lower friction in the air
			velocity.x = lerp(velocity.x, 0, 0.1)
			is_in_air = true
		