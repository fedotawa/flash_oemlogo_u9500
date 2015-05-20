###Automatic oemlogo flasher for Huawei U9500


###Usage

  Just launch the batch file from Explorer or type 

     `flash_oemlogo image_to_flash.bmp`

  in terminal.

  The command 

    `flash_oemlogo rescue`

  will flash the default Huawei logo, which may be useful if the screen
  of your phone doesn't work but ADB connection is still available.


####Supported image formats

  720x1280 PNG and Windows BMP only.
  Images of other dimensions may cause unpredictable hardware failures.


####Requirements

  root, USB debugging enabled.


####Notes

  The tool is based on a modified Huawei's load_oemlogo executable, which now doesn't
  require the presence of /data/custom.bin file and takes image from /cust/oemlogo.mbn.

  Huawei uses raw arrays of BGR24 (24bit) pixels as their oemlogo file format   
  for U9500, although the pixels should use colors from 16bit (or even less) RGB color space. 
  Even in this case some images may not display or drive your video-memory crazy. 
  Try differend approaches for color downsampling and use with caution.
