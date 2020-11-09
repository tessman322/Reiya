extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $menu/CenterRow/buttons.get_children():
		button.connect("pressed",self,"_on_Button_Pressed",[button.scene_to_load])

func _on_Button_Pressed(scene_to_load):
	if scene_to_load != "exit":
		get_tree().change_scene(scene_to_load)
	else:
		get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
