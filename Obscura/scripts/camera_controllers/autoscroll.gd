class_name AutoscrollingCamera
extends CameraControllerBase

@export var topLeft:Vector2 
@export var bottomLeft:Vector2 
@export var autoscroll_speed:Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#If the character touches the left border or right border, push the character
	position += autoscroll_speed * delta
	#target.global_position.move_toward(autoscroll_speed * delta, delta)
	
	# Finding Box Width and Box Height Borders
	var box_width = topLeft.x - bottomLeft.x 
	var box_height = topLeft.y - bottomLeft.y 
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks : if the player is at the edge of the boundary trasport the player at that specific position
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		target.global_position.x = (cpos.x - box_width / 2.0) 
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		target.global_position.x = (cpos.x + box_width / 2.0)
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		target.global_position.z = (cpos.z - box_height / 2.0)
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		target.global_position.z = (cpos.z + box_height / 2.0)
		
	super(delta)
	
