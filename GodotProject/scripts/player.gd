extends KinematicBody2D

var velocity = Vector2(0, 0)
export var speed = Vector2(300.0, 100.0)
export var gravity = 500.0
export var dashSpeed = 850.0
export var vertDashSpeed = 1000.0

var dashing = -1
var dashDirection = ""

func _physics_process(delta):
	if Input.is_action_just_pressed("shift") and dashing == -1:
		dashing = 10
		if Input.get_action_strength("right") == Input.get_action_strength("left"):
			dashing = -1
		elif Input.get_action_strength("right") > Input.get_action_strength("left"):
			dashDirection = "right"
		else:
			dashDirection = "left"
	
	if is_on_floor():
		velocity.y = 0
	var direction = Vector2(Input.get_action_strength("right")-Input.get_action_strength("left"), -1.0 if (Input.is_action_just_pressed("z") or Input.is_action_just_pressed("space")) and is_on_floor() else 1.0)
	velocity.x = speed.x * direction.x
	velocity.y += gravity * delta
	if direction.y == -1.0:
		velocity.y = speed.y * direction.y
	
	if dashing >= 0:
		if dashDirection == "left":
			velocity.x = -dashSpeed
			velocity.y = 0
		if dashDirection == "right":
			velocity.x = dashSpeed
			velocity.y = 0
		dashing -= 1
	move_and_slide(velocity, Vector2.UP)
