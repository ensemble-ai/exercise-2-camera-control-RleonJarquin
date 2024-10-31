class_name PositionLockLerpingCamera
extends CameraControllerBase

@export var follow_speed:float
@export var catchup_speed:float
@export var leash_distance:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	var tpos = target.global_position
	var cpos = global_position
	
	#If the camera is at max leash distance. Have the camera go at the same speed as the player
	if Vector2(cpos.x, cpos.z).distance_to(Vector2(tpos.x,tpos.z)) > leash_distance:
		var new_cpos = global_transform.origin + target.velocity
		global_position.lerp(new_cpos, target.velocity.length())
	else:
		#If the player is moving follow the camera at follow speed. Otherwise if not moving follow at catchup speed.
		if(target.velocity.length() != 0):
			global_position.lerp(tpos, follow_speed * target.velocity.length())
		else:
			global_position.lerp(tpos, catchup_speed * target.velocity.length())

	
	if draw_camera_logic:
		draw_logic()
		
	super(delta)
	
func draw_logic() -> void:
	pass
