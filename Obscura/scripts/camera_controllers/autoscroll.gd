class_name AutoscrollingCamera
extends CameraControllerBase

@export var topLeft:Vector2 
@export var bottomRight:Vector2 
@export var autoscroll_speed:Vector3

# Finding Box Width and Box Height Borders
var box_width:float
var box_height:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	box_width = topLeft.x - bottomRight.x 
	box_height = topLeft.y - bottomRight.y 
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
	
	#Apply a new velocity to the player
	var smoothing = 0.1
	var new_direction = Vector3(autoscroll_speed + target.velocity).normalized()
	var new_speed = Vector3(autoscroll_speed + target.velocity).length()
	var new_velocity = new_direction * new_speed
	#target.velocity = new_velocity
	
	target.global_position.x = target.global_position.x + new_velocity.x * delta
	target.global_position.z = target.global_position.z + new_velocity.z * delta

	
	#If the character touches the left border or right border, push the character
	position += autoscroll_speed * delta
	#target.global_position.move_toward(autoscroll_speed * delta, delta)
	
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
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -box_width / 2
	var right:float = box_width / 2
	var top:float = -box_height / 2
	var bottom:float = box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()

	
	
