extends Spatial

export var initial_height = 1.0
export var initial_distance = 10.0
export var initial_pitch = -30

export var speed_movement = 1.0
export var speed_rotation = 1.0


export var pitch_min = 0
export var pitch_max = -80
export var pitch_speed = 1.0

export var zoom_min = 0.1
export var zoom_max = 5.0
export var zoom_speed = 1.0

const MOVE_FORWARD = "camera_move_forward"
const MOVE_BACKWARD = "camera_move_backward"
const MOVE_LEFT = "camera_move_left"
const MOVE_RIGHT = "camera_move_right"

const ROTATE_LEFT = "camera_rotate_left"
const ROTATE_RIGHT = "camera_rotate_right"

const PITCH_UP = "camera_pitch_up"
const PITCH_DOWN = "camera_pitch_down"

const ZOOM_IN = "camera_zoom_in"
const ZOOM_OUT = "camera_zoom_out"

func _ready():
	# Initial height, distance and pitch
	self.translate( Vector3( 0, self.initial_height, 0 ) )
	$Rotation/Pitch/Camera.translate( Vector3( 0, 0, self.initial_distance ) )
	$Rotation/Pitch.rotation_degrees.x = self.initial_pitch

func _process( delta ):
	self._handle_movement()
	self._handle_rotation()
	self._handle_pitch()
	self._handle_zoom()

func _handle_movement():
	var camera = $Rotation/Pitch/Camera.get_camera_transform()
	var move = Vector3()
	
	if Input.is_action_pressed( MOVE_FORWARD ):
		move -= camera.basis[2]
	elif Input.is_action_pressed( MOVE_BACKWARD ):
		move += camera.basis[2]
	
	if Input.is_action_pressed( MOVE_LEFT ):
		move -= camera.basis[0]
	elif Input.is_action_pressed( MOVE_RIGHT ):
		move += camera.basis[0]
	
	move.y = 0
	move = move.normalized() * 0.2 * self.speed_movement
	
	self.translate( move )
	
func _handle_rotation():
	if Input.is_action_pressed( ROTATE_LEFT ):
		$Rotation.rotate_y( -0.05 * self.speed_rotation )
	elif Input.is_action_pressed( ROTATE_RIGHT ):
		$Rotation.rotate_y( 0.05 * self.speed_rotation )

func _handle_pitch():
	if Input.is_action_pressed( PITCH_UP ) && $Rotation/Pitch.rotation_degrees.x >= self.pitch_max:
		$Rotation/Pitch.rotate_x( -0.05 * self.pitch_speed )
	elif Input.is_action_pressed( PITCH_DOWN ) && $Rotation/Pitch.rotation_degrees.x <= self.pitch_min:
		$Rotation/Pitch.rotate_x( 0.05 * self.pitch_speed )

func _handle_zoom():
	var zoom = Vector3( 0.05, 0.05, 0.05 ) * self.zoom_speed
	
	if Input.is_action_pressed( ZOOM_IN ) && self.scale.x >= self.zoom_min:
		self.scale = self.scale - zoom
	elif Input.is_action_pressed( ZOOM_OUT ) && self.scale.x <= self.zoom_max:
		self.scale = self.scale + zoom

