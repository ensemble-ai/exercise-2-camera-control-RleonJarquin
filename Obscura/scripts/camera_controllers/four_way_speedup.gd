class_name FourWaySpeedupCamera
extends CameraControllerBase

@export var push_ratio:float
@export var pushbox_top_left:Vector2
@export var pushbox_bottom_right:Vector2
@export var speedup_zone_top_left:Vector2
@export var speedup_zone_bottom_right:Vector2

var pushbox_height:float 
var pushbox_width:float
var speedup_box_height:float
var speedup_box_width:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pushbox_height = pushbox_top_left.y - pushbox_bottom_right.y
	pushbox_width = pushbox_bottom_right.x - pushbox_top_left.x
	speedup_box_height = speedup_zone_top_left.y - speedup_zone_bottom_right.y
	speedup_box_width = speedup_zone_bottom_right.x - speedup_zone_top_left.x
	super()
	
func update_box_pos(width, height, direction, cpos_delta) -> void:
		var tpos = target.global_position
		var cpos = target.global_position
		
		#left
		var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - width / 2.0)
		if diff_between_left_edges < 0: #and direction.x < 0:
			global_position.x = (cpos.x - cpos_delta.x)
		#right
		var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + width / 2.0)
		if diff_between_right_edges > 0: #and direction.x > 0:
			global_position.x = (cpos.x + cpos_delta.x)
		#top
		var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - height / 2.0)
		if diff_between_top_edges < 0: #and direction.y < 0:
			global_position.z = (cpos.z - cpos_delta.z)
		#bottom
		var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + height / 2.0)
		if diff_between_bottom_edges > 0: #and direction.y > 0:
			global_position.z = (cpos.z + cpos_delta.z)
	
	
func within_box_bounds(box_width, box_height) -> bool:
	var tpos = target.global_position
	var cpos = global_position
	
	var within_x = abs(tpos.x - cpos.x) - box_width / 2 > 0
	var within_z = abs(tpos.z - cpos.z) - box_height / 2 > 0
		
	return within_x and within_z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current: 
		return
		
	if draw_camera_logic:
		draw_logic()
		
	var tpos = target.global_position
	var cpos = global_position
	var tpos_direction = target.velocity.normalized()
	print("Hello")
	
	##if player is not in the speed up zone box.
	if not within_box_bounds(speedup_box_width, speedup_box_width):
		#If the player is not within the pushbox then lerp to the destination
				#If the player touches the outside border then lerp the camera border at the edge of the player (x-z) 
		if within_box_bounds(pushbox_width, pushbox_height):
			var my_velocity = target.velocity * push_ratio
			var cpos_delta = my_velocity * delta 
			update_box_pos(speedup_box_width, speedup_box_height, tpos_direction, cpos_delta)
		else:
			var cpos_delta = tpos - cpos
			update_box_pos(pushbox_width, pushbox_height, tpos_direction, cpos_delta)

	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -pushbox_width / 2
	var right:float = pushbox_width / 2
	var top:float = -pushbox_height / 2
	var bottom:float = pushbox_height / 2
	
	var left2:float = -speedup_box_width / 2
	var right2:float = speedup_box_width / 2
	var top2:float = -speedup_box_height / 2
	var bottom2:float = speedup_box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(right2, 0, top2))
	immediate_mesh.surface_add_vertex(Vector3(right2, 0, bottom2))
	
	immediate_mesh.surface_add_vertex(Vector3(right2, 0, bottom2))
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, bottom2))
	
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, bottom2))
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, top2))
	
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, top2))
	immediate_mesh.surface_add_vertex(Vector3(right2, 0, top2))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
