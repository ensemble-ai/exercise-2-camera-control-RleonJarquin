class_name FourWaySpeedupCamera
extends CameraControllerBase

@export var push_ratio:float
@export var pushbox_top_left:Vector2
@export var pushbox_bottom_right:Vector2
@export var speedup_zone_top_left:Vector2
@export var speedup_zone_bottom_right:Vector2

var pushbox_height = abs(pushbox_top_left.y - pushbox_bottom_right.y)
var pushbox_width = abs(pushbox_bottom_right.x - pushbox_top_left.x)
var speedup_box_height = abs(speedup_zone_top_left.y - speedup_zone_bottom_right.y)
var speedup_box_width = abs(speedup_zone_bottom_right.x - speedup_zone_top_left.x)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position
	
func lerp_global(current_position: Vector3, target_position: Vector3, t: float) -> Vector3:
	var x = lerp(current_position.x, target_position.x, t)
	var y = lerp(current_position.y, target_position.y, t)
	var z = lerp(current_position.z, target_position.z, t)
	return Vector3(x, y, z)
	
func within_speedup_zone() -> bool:
	var within_x = abs(target.global_position.x - global_position.x) - speedup_box_width/2 > 0 
	var within_y = abs(target.global_position.y - global_position.y) - speedup_box_height/2 > 0 
	return within_x and within_y
	
func within_push_zone() -> bool:
	var within_x = abs(target.global_position.x - global_position.x) - pushbox_width/2 > 0 
	var within_y = abs(target.global_position.y - global_position.y) - pushbox_height/2 > 0 
	return within_x and within_y
	
func between_push_and_speedup_zone() -> bool:
	return within_push_zone() and not within_speedup_zone()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !current: 
		return
		
	if draw_camera_logic:
		draw_logic()
	
	##if player is in the in the speed up zone box. If so do nothing (x-z)
	if !within_speedup_zone():
		#If the box is between the speed up zone and you are moving in the direction of the border
		#slow down then speed towards the target (x-z)
		if between_push_and_speedup_zone() and target.velocity.length() != 0:
			var my_velocity_x = target.velocity.x * push_ratio
			var my_velocity_z = target.velocity.z * push_ratio
			var curr_pos = global_position
			var new_pos = Vector3(global_position.x + my_velocity_x * delta, global_position.y, global_position.z + my_velocity_z * delta)
			global_position = new_pos
			
		#If the player touches the outside border then move at the speed of the player. (x-z) 
		if not within_push_zone():
			var curr_pos = global_position
			var new_pos = Vector3(global_position.x + target.velocity.x * delta, global_position.y, global_position.z + target.velocity.z * delta)
			global_position = new_pos
	
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
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, bottom2))
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, top2))
	
	immediate_mesh.surface_add_vertex(Vector3(left2, 0, top2))
	immediate_mesh.surface_add_vertex(Vector3(right2, 0, top2))
	immediate_mesh.surface_end()

	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color.BLACK
	
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
