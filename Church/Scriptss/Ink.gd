# warning-ignore-all:return_value_discarded

extends Control

var InkPlayer = load("res://addons/inkgd/ink_player.gd")

onready var _ink_player = InkPlayer.new()
onready var _choice_box = load("res://Scenes/Choice.tscn")
onready var _audio = load("res://Scenes/Choice.tscn")
var _should_accept_input = true
var _story = ""
var _ignore_choices = []

signal mouse_click
signal wait_for_tag
signal call_sfx(sfx)
signal stop_sfx

func _ready():
	# Adds the player to the tree.
	add_child(_ink_player)

	_ink_player.ink_file = load("res://Ink/The Church.ink.json")

	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", self, "_story_loaded")

	_ink_player.create_story()


# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return

	# _observe_variables()
	# _bind_externals()

	_continue_story()

func _input(event):
	if (event is InputEventKey):
		if(event.pressed and event.is_action_pressed("ui_accept")):
			emit_signal("mouse_click")
		
# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	yield(VisualServer, "frame_post_draw")
	_should_accept_input = true;
		
	if _ink_player.can_continue:
		_story = _ink_player.continue_story()
		var story_text = get_node("Label")
		var tags = _ink_player.current_tags
		_parse_text()
		
		if _ink_player.has_choices:
			# 'current_choices' contains a list of the choices, as strings.
			var index = 0
			_should_accept_input = false
			for choice in _ink_player.current_choices:
				#if it's a on click change
				if (!_ignore_choices.empty()):
					index += 1
					continue
				
				#create our button
				var button = _choice_box.instance() 	
				
				if ("<" in choice and ">" in choice):
					var position = choice.find(">") + 2
					var jump_to = choice.substr(position)
					choice = choice.replace("<", "").replace("> " + jump_to, "")
					print(choice)
					button.connect("mouse_entered", self, "_on_choice_hover", [jump_to, button])
					
					
				
				button.text = choice
				button.connect("pressed", self, "_select_choice", [index])
				index += 1
				
				$ColorRect/Choice_Container.add_child(button)
		
		story_text.bbcode_text = "[center]" + _story
		
		if !tags.empty():
			for tag in tags:
				_check_tags(tag)
			yield(self,"wait_for_tag")
		
		if _should_accept_input:
			_show_next_line();
		
	else:
		# This code runs when the story reaches it's end.
		print("The End")
		
func _show_next_line():
	yield(get_tree().create_timer(0.25), "timeout")
	yield(self,"mouse_click")
	_continue_story()

func _check_tags(tag):
	if ("delay:" in tag):
		#syntax: delay: [time]
		_should_accept_input = false;
		var time = tag.substr(6)
		yield(get_tree().create_timer(float(time)), "timeout")
		_continue_story()
		print("delay")
	elif ("style:" in tag):
		var style = tag.substr(6)
		_style_text(style)
		print("style: " + style + " on: " + _story)
	elif ("play:" in tag):
		#syntax: play: [delay], [sfx], [fade in]
		var sfx = tag.substr(6)
		emit_signal("call_sfx", sfx)
		print("play: " + sfx + " with: " + _story)		
	elif ("stop:" in tag):
		#syntax: play: [delay], [sfx], [fade out]
		print("stop")
	
	emit_signal("wait_for_tag")

func _style_text(style):
	print(style)

func _select_choice(index):
	_ink_player.choose_choice_index(index)
	
	for child in $ColorRect/Choice_Container.get_children():
		$ColorRect/Choice_Container.remove_child(child)
		child.queue_free()
		
	_continue_story()
	_ignore_choices.clear()
	_should_accept_input = true;
	
func _parse_text():
	var is_start = false
	var index = 0
	for character in _story:
		if (character == "_"):
			if (is_start):
				is_start = false
				_story = _story.insert(index, "[/i]")
				index += 3
			else:
				is_start = true
				_story = _story.insert(index, "[i]")
				index += 3
		elif (character == "["):
			if (is_start):
				var jump_to = 0 if _ignore_choices.empty() else _ignore_choices.max()
				_story = _story.insert(index - 1, "[color=#771414]")
				is_start = false
				index += 15
				_story = _story.insert(index - 1, "[url= {0}]").format([jump_to])
				index += 10
			else:
				is_start = true
		elif (character == "]"):
			if (is_start):
				_story = _story.insert(index - 1, "[/url]")
				index += 6				
				_story = _story.insert(index - 1, "[/color]")
				is_start = false
				index += 8
				_check_ignored_choices()
			else:
				is_start = true
		elif (character == "<"):
			var end = _story.find(">", index)
			var text = _story.substr(index + 1, end - index)
			var cycle = text.split(",", false)
		index += 1
		
	#remove the debug info
	_story = _story.replace("_", "").replace("[[", "").replace("]]", "")
	print(_story)

func _check_ignored_choices():
	if (_ignore_choices.empty()):
		_ignore_choices.append(0)
	else:
		_ignore_choices.append(_ignore_choices.max() + 1)

func _on_Label_meta_clicked(meta):
	_select_choice(int(meta))

func _on_choice_hover(meta, button):
	button.text = str(meta)
	pass 

# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
# 	pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
# func _observe_variables():
# 	_ink_player.observe_variables(["var1", "var2"], self, "_variable_changed")
#
#
# func _variable_changed(variable_name, new_value):
# 	print("Variable '%s' changed to: %s" %[variable_name, new_value])
