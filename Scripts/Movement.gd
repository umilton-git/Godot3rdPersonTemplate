extends CharacterBody3D

var movement_speed
var walk_speed = 5.0
var run_speed = 10.0

var vertical_velocity = 0
var gravity = 50

var acceleration = 6
var angular_acceleration = 7
var jump_impulse = 30


func get_input(delta):
	var h_rot = $CamRoot/h.global_transform.basis.get_euler().y
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back") * Vector2(-1, -1)
	var direction = Vector3(input.x, 0, input.y).rotated(Vector3.UP, h_rot).normalized()

	if direction.length() > 0:
		$TestCube.rotation.y = lerp_angle($TestCube.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
		if Input.is_action_pressed('sprint'):
			if(is_on_floor()):
				movement_speed = run_speed
		else:
			if(is_on_floor()):
				movement_speed = walk_speed
	else:
		movement_speed = 0
		
	if Input.is_action_just_pressed('Jump') and is_on_floor():
		velocity.y = jump_impulse

	var target_velocity = direction * movement_speed
	velocity = velocity.lerp(target_velocity, delta * acceleration)	

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		
	get_input(delta)
	move_and_slide()
