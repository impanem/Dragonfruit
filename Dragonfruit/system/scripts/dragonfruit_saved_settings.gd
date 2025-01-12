extends Resource
class_name DragonfruitSettings

@export var autostart_slides_vid: bool = true

@export var saved_bg_mode: int = 0

@export var saved_single_image: CompressedTexture2D = null

@export var saved_slideshow_switch_time: int = 1

@export var saved_vid_method: int = 0
@export var saved_custom_video_path: String = ""
@export var saved_bus: String = "Master"
@export_range(-80, 5, 0.5, "suffix:dB") var saved_video_volume: float = -25.0

@export var saved_modulate_color: Color = Color(0.137255, 0.137255, 0.137255, 1) # Hex Code #222222

@export var saved_h_axis_stretch: int = 0
@export var saved_v_axis_stretch: int = 0
