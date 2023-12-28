extends Node3D

var camrot_h = 0.0
var camrot_v = 0.0
var cam_v_min = -160
var cam_v_max = 120
var h_sensitivity = 0.3
var v_sensitivity = 0.3
var h_acceleration = 10
var v_acceleration = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity
	if Input.is_action_pressed("unlockCam"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	$h.rotation_degrees.y = lerp($h.rotation_degrees.y, camrot_h * 1.0, delta * h_acceleration)
	$h.rotation_degrees.x = lerp($h/v.rotation_degrees.x, camrot_v * 1.0, delta * v_acceleration)
	
