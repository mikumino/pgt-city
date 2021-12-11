extends TextureRect

export var dialoguePath = ""
export (float) var textSpeed = 0.05

var dialogue

func _ready():
	$Timer.wait_time = textSpeed
	dialogue = getDialogue()

func getDialogue():
	var file = File.new()
	assert(file.file_exists(dialoguePath), "Dialogue not found") # assert checks for truth and prints otherwise
	
	file.open(dialoguePath, File.READ)
	var json = file.get_as_text()
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		pass
