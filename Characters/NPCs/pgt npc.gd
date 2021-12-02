extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.set_active_object(get_node("."))
		print("object set")

func interact():
	print("interaction success")


func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		body.set_active_object(null)
		print("reference removed")
