class_name AutoscrollingCamera
extends CameraControllerBase

@export var topLeft:Vector2 
@export var bottomLeft:Vector2 
@export var autoscroll_speed:Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	target.velocity = autoscroll_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#If the character touches the left border or right border, push the character
	position = autoscroll_speed * delta
	
	# Finding Box Width and Box Height Borders
	var box_width = topLeft.x - bottomLeft.x 
	var box_height = topLeft.y - bottomLeft.y 
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
		
	super(delta)
	
