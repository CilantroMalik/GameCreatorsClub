extends KinematicBody2D

var velocity = Vector2(0, 0)
export var speed = Vector2(200.0, 220.0)
export var gravity = 475.0
export var dashSpeed = 500.0
export var vertDashSpeed = 1000.0
export var easeRatio = 0.2

var dashing = -1
var dashDirection = ""

func _physics_process(delta):
	# Handle dashing
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
	var direction = Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"), 
		-1.0 if (Input.is_action_just_pressed("z") or Input.is_action_just_pressed("space")) and is_on_floor() else 1.0
	)
	if direction.x != 0:
		velocity.x += speed.x * direction.x * easeRatio
		velocity.x = clamp(velocity.x, -speed.x, speed.x)
	elif direction.x == 0:
		var slowSpeed = 4*easeRatio if is_on_floor() else easeRatio
		if velocity.x > 0:
			velocity.x -= speed.x * slowSpeed
			velocity.x = clamp(velocity.x, 0, 999)
		elif velocity.x < 0:
			velocity.x += speed.x * slowSpeed
			velocity.x = clamp(velocity.x, -999, 0)
		if velocity.x >= -5 and velocity.x <= 5:
			velocity.x = 0
		
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
