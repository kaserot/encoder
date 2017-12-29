@echo off

SETLOCAL enabledelayedexpansion

set input_file=%1
set suffix=_output.mp4
set output_file=%input_file:~0,-4%%suffix%

set/P is_speed_change="���x�ύX����H(y/n)"
if "%is_speed_change%"=="y" (
  set/P speed_option="���{���H�i0.5�`2�j"
  set ffmpeg_option=setpts=PTS/!speed_option! -af atempo=!speed_option!
)

set/P is_resize="resize?(y/n)"
if "%is_resize%"=="y" (
  set/P x="�����i��F1920/1600/1280/1024/800�j"
  set ffmpeg_option=scale=!x!:-1,%ffmpeg_option%
)

if not "%ffmpeg_option%."=="." (
  set ffmpeg_option=-vf %ffmpeg_option%
)

ffmpeg.exe -i %input_file% -vcodec h264_nvenc %ffmpeg_option% %output_file%
rem ffmpeg.exe -i "hogehoge.mp4" -vcodec h264_nvenc -vf setpts=PTS/2.0 -af atempo=2.0 dest.mp4

pause

ENDLOCAL