extends KinematicBody
var MAX_Speed:int=30
var acceleration:int=120
var jumpforce:int=55
var gravity:int=180

var last_axis_x:int=0
var last_axis_z:int=0
var velocity:Vector3=Vector3.ZERO

func _physics_process(delta):
	var axis=get_input_axis()
	if axis==Vector3.ZERO:
		apply_friction(acceleration*delta)
	else:
		apply_movement(axis,acceleration*delta)
	velocity.y-=gravity*delta
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y+=jumpforce
	velocity=move_and_slide(velocity,Vector3.UP)
#	print(velocity)
#	print(get_slide_collision(1))
#	velocity=Vector3.ZERO
#	print(velocity.sign())
	

func get_input_axis():
	var axis=Vector3.ZERO
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		axis.x=1
		last_axis_x=1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		axis.x=-1
		last_axis_x=-1
	if Input.is_action_pressed("move_out") and not Input.is_action_pressed("move_in"):
		axis.z=1
		last_axis_z=1
	if Input.is_action_pressed("move_in") and not Input.is_action_pressed("move_out"):
		axis.z=-1
		last_axis_z=-1
	if Input.is_action_pressed("move_out") and Input.is_action_pressed("move_in"):
		axis.z=-last_axis_z
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		axis.x=-last_axis_x
	return axis.normalized()

func apply_friction(fr_amount):
	var vel_sign_x:int
	var vel_sign_z:int
	if sqrt((velocity.x*velocity.x)+(velocity.z*velocity.z))>fr_amount:
		if(velocity.x>-1) and velocity.x<1:
			vel_sign_x=0
		else:
			vel_sign_x=velocity.sign().x
		if(velocity.z>-1) and velocity.z<1:
			vel_sign_z=0
		else:
			vel_sign_z=velocity.sign().z
			
		velocity.x-=vel_sign_x*fr_amount
		velocity.z-=vel_sign_z*fr_amount
	else:
		velocity.x=0
		velocity.z=0
	print(velocity.z)
		
		
func apply_movement(axis,accl_amount):
#	print(axis.z)
	velocity.x+=axis.x*accl_amount
	velocity.z+=axis.z*accl_amount
#	print(accl_amount,'   ',axis.z,'   ',velocity.z)
	if sqrt((velocity.x*velocity.x)+(velocity.z*velocity.z))>MAX_Speed:
		if velocity.x==0:
			velocity.z=axis.z*MAX_Speed
		elif velocity.z==0:
			velocity.x=axis.x*MAX_Speed
		else:
			velocity.x=axis.x*MAX_Speed/1.414
			velocity.z=axis.z*MAX_Speed/1.414
#	print(velocity)
