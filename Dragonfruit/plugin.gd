@tool
extends EditorPlugin

const DRAGONFRUIT = preload("res://addons/Dragonfruit/system/scripts/dragonfruit.gd")
const TOOL_PANEL = preload("res://addons/Dragonfruit/system/scenes/tool_panel.tscn")
var new_tool_panel

func _enter_tree():
	new_tool_panel = TOOL_PANEL.instantiate()
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, new_tool_panel)

func _exit_tree():
	remove_control_from_docks(new_tool_panel)
	
	# Remove video child from Code Editor
	var the_code_editor = EditorInterface.get_script_editor().get_current_editor().get_base_editor()
	if not the_code_editor.get_children().is_empty():
		for child in the_code_editor.get_children():
			child.queue_free()
	
	# Only remove custom theme if it's styleboxempty.
	# This is for the video because it does that.
	if DirAccess.dir_exists_absolute(DRAGONFRUIT.SINGLE_BG_FILE_PATH):
		for custom_theme_file in DirAccess.get_files_at(DRAGONFRUIT.SINGLE_BG_FILE_PATH):
			var file = load(DRAGONFRUIT.SINGLE_BG_FILE_PATH + custom_theme_file)
			if file is Theme:
				var stylebox = file.get_stylebox("normal", "CodeEdit")
				
				if stylebox is StyleBoxEmpty:
					DirAccess.remove_absolute(DRAGONFRUIT.SINGLE_BG_FILE_PATH + custom_theme_file)
					
					var custom_editor_theme_setting = EditorInterface.get_editor_settings()
					custom_editor_theme_setting.set_setting("interface/theme/custom_theme", "")
	
	if not EditorInterface.get_resource_filesystem().is_scanning():
		EditorInterface.get_resource_filesystem().scan()
	
	new_tool_panel.queue_free()
