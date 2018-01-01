@echo off

SETLOCAL enabledelayedexpansion

set input_file=%1
set suffix=_output.mp4
set output_file=%input_file:~0,-4%%suffix%

set/P is_trimming="�؂�o��?(y/n)"
if "%is_trimming%"=="y" (
  set/P start_time="�ǂ�����H�i�b�j"
  set/P end_time="�ǂ��܂ŁH�i�b�j"
  set /a trimming_time=end_time - start_time
  set trim_start_option=-ss !start_time!
  set trim_end_option=-t !trimming_time!
)

set/P is_speed_change="���x�ύX����H(y/n)"
if "%is_speed_change%"=="y" (
  set/P reproduction_speed="���{���H�i0.5�`2�j"
  set speed_option=setpts=PTS/!reproduction_speed! -af atempo=!reproduction_speed!
)

set/P is_resize="resize?(y/n)"
if "%is_resize%"=="y" (
  set/P x="�����i��F1920/1600/1280/1024/800�j"
  set resize_option=scale=!x!:-1
)

if "%is_speed_change%"=="y" if "%is_resize%"=="y" (
  set ffmpeg_option=%speed_option%,%resize_option%
) else (
  set ffmpeg_option=%speed_option%%resize_option%
)

if not "%ffmpeg_option%."=="." (
  set ffmpeg_option=-vf %ffmpeg_option%
)

ffmpeg.exe %trim_start_option% -i %input_file% %trim_end_option% -vcodec h264_nvenc %ffmpeg_option% %output_file%
rem ffmpeg.exe -i "hogehoge.mp4" -vcodec h264_nvenc -vf setpts=PTS/2.0 -af atempo=2.0 dest.mp4

pause

ENDLOCAL