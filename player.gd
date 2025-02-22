extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	var input_axis = Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animations(input_axis)
	move_and_slide()

func update_animations(input_axis):
		if input_axis !=0:
			animated_sprite_2d.flip_h = (input_axis >0)
			animated_sprite_2d.play("move")
		else:
			animated_sprite_2d.play("idle")
		if not is_on_floor():
			animated_sprite_2d.play("jump")
