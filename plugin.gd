@tool
extends EditorPlugin

const DRAGONFRUIT: Script = preload("res://addons/Dragonfruit/system/scripts/dragonfruit.gd")
const DRAGONFRUIT_PANEL = preload("res://addons/Dragonfruit/system/scenes/dragonfruit_panel.tscn")
var df_panel: Control

func _enter_tree() -> void:
	df_panel = DRAGONFRUIT_PANEL.instantiate()
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, df_panel)

func _exit_tree() -> void:
	remove_control_from_docks(df_panel)
	
	# Remove video child from Code Editor
	var the_code_editor: Control = EditorInterface.get_script_editor().get_current_editor().get_base_editor()
	if not the_code_editor.get_children().is_empty():
		for child: Node in the_code_editor.get_children():
			child.queue_free()
	
	# Only remove custom theme if it's styleboxempty.
	# This is for the video because it does that.
	if DirAccess.dir_exists_absolute(DRAGONFRUIT.SINGLE_BG_FILE_PATH):
		for custom_theme_file: String in DirAccess.get_files_at(DRAGONFRUIT.SINGLE_BG_FILE_PATH):
			var file: Resource = load(DRAGONFRUIT.SINGLE_BG_FILE_PATH + custom_theme_file)
			if file is Theme:
				var stylebox: StyleBox = file.get_stylebox("normal", "CodeEdit")
				
				if stylebox is StyleBoxEmpty:
					DirAccess.remove_absolute(DRAGONFRUIT.SINGLE_BG_FILE_PATH + custom_theme_file)
					
					var custom_editor_theme_setting: EditorSettings = EditorInterface.get_editor_settings()
					custom_editor_theme_setting.set_setting("interface/theme/custom_theme", "")
	
	if not EditorInterface.get_resource_filesystem().is_scanning():
		EditorInterface.get_resource_filesystem().scan()
	
	df_panel.queue_free()
