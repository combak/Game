extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var begin : Vector3 = $Navigation/Begin.translation
	var end : Vector3 = $Navigation/End.translation
	var path = $Navigation.get_simple_path( begin, end , false )

	



func _input(event):
	if event.is_action_pressed("mouse_click_left"):
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
