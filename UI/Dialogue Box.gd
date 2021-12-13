extends TextureRect

export var dialoguePath = ""
export (float) var textSpeed = 0.05

var dialogue
var phraseNum = 0;
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialogue = getDialogue()
	assert(dialogue, "Dialogue not found")
	nextPhrase()
	$Fade.play("fade_in")
	print("dialogue sent")
	
func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("check"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialogue():
	var file = File.new()
	assert(file.file_exists(dialoguePath), "File not found") # assert checks for truth and prints otherwise
	
	file.open(dialoguePath, File.READ)
	var json = file.get_as_text()
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase():
	if phraseNum >= len(dialogue):
		$Fade.play("fade_out")
		yield($Fade, "animation_finished")
		queue_free()
		connect("tree_exited", get_node("/root/World/YSort/Player"), "exit_interaction")
		return
	finished = false
	
	$Name.bbcode_text = dialogue[phraseNum]["Name"]
	$Text.bbcode_text = dialogue[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		$Timer.start()
		yield($Timer, "timeout")	# This starts a timer and stops the function until the timer times out
	
	finished = true
	phraseNum += 1
	return
