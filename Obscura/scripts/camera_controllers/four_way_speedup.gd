class_name FourWaySpeedupCamera
extends CameraControllerBase

@export var pushbox_top_left:Vector2
@export var pushbox_bottom_right:Vector2
@export var speedup_zone_top_left:Vector2
@export var speedup_zone_bottom_right:Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		
	super(delta)
	
func draw_logic() -> void:
	pass
	
