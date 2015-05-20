echo off

if "%~1." == "rescue." goto rescue

if not "%~1." == "." goto user_file

set IMAGE_FILE=oemlogo.bmp
goto begin

:rescue

del oemlogo.mbn >nul 2>&1
copy .\bin\huawei_original_logo\oemlogo.mbn .\oemlogo.mbn
goto prepare_tools

:user_file

set IMAGE_FILE=%1

:begin

echo.
echo Converting image...

del oemlogo.mbn  >nul 2>&1

.\bin\ffmpeg.exe -vcodec %IMAGE_FILE:~-3% -i %IMAGE_FILE%  -vcodec rawvideo -f rawvideo -pix_fmt rgb565 oemlogo.raw >nul 2>&1
.\bin\ffmpeg.exe -vcodec rawvideo -f rawvideo -pix_fmt rgb565 -s 720x1280 -i oemlogo.raw -vcodec rawvideo -f rawvideo -pix_fmt bgr24 oemlogo.mbn >nul 2>&1
del oemlogo.raw

:prepare_tools

for /f "delims=" %%A in ('.\bin\adb.exe shell "test -e /cust/media/bin/flash_oemlogo && echo 1"') do set "flasher_presents=%%A"

if "%flasher_presents%" == "1" goto do_flash

echo.
echo Installing tools...

.\bin\adb.exe shell "mkdir /cust/media/bin" >nul 2>&1
.\bin\adb.exe push ./bin/flash_oemlogo /cust/media/bin >nul 2>&1
.\bin\adb.exe shell "chmod 744 /cust/media/bin/flash_oemlogo"
.\bin\adb.exe push ./bin/liboeminf2.so /cust/media/bin >nul 2>&1

:do_flash

echo.
echo Flashing, please wait...

.\bin\adb.exe push ./oemlogo.mbn /cust/media >nul 2>&1

.\bin\adb.exe shell "export export LD_LIBRARY_PATH=/cust/media/bin;/cust/media/bin/flash_oemlogo"
del oemlogo.mbn

echo.
echo Done.
echo.

:end

pause