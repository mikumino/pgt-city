extends StaticBody2D

export var dialogue_path = ""
var dialogue_box = load("res://UI/Text Box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.set_active_object(get_node("."))
		print("object set")

func interact():
	print("interaction success")
	var dialogue = dialogue_box.instance()
	dialogue.get_node("Dialogue Box").dialoguePath = dialogue_path
	get_node("/root/World/UI").add_child(dialogue)
	print("child added")
	get_node("/root/World/YSort/Player").isFree = false


func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		body.set_active_object(null)
		print("reference removed")
