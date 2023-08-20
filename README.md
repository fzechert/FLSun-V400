# FLSUN V400 Cura Printer Profiles

The profiles in this repository are intended for a FLSun V400 3D printer, that has been flashed over to the
official version of Klipper (e.g. by following the process described in <https://github.com/Guilouz/Klipper-Flsun-Speeder-Pad>). 
It may be incompatible with the modified FLSun version of Klipper!

Large parts of the profiles have been taken from [phnxdrgn536/FLSun-v400](https://github.com/phnxdrgn536/FLSun-v400). They have been modified and simplified
(e.g. some materials, nozzle sizes and intents were omitted).

An install script ([install.sh](install.sh)) has been added to support installation on linux.  
**Warning:** Read and configure [install.sh](install.sh) before you execute it. **It will delete some files on your hard disk!**

## How Profiles are Loaded

Cura loads printer quality configuration files in a stack. The following files must be present for a profile to work:

1. The file `quality/flsun_v400_global_<quality>_Quality.inst.cfg` defines some global properties for all nozzle sizes and materials.
   Linking global qualities to layer heights is a valid example, but not a must. Cura's intention seems to be centered on print speed.  
   Possible values for `<quality>` are (at least one needs to be present):
   - `Superdraft` (e.g. for a layer height of `0.4`)
   - `Verydraft` (e.g. for a layer height of `0.3`)
   - `Draft` (e.g. for a layer height of `0.2`)
   - `Fast` (e.g. for a layer height of `0.15`)
   - `Normal` (e.g. for a layer height of `0.1`)
   - `High` (e.g. for a layer height of `0.06`)
2. On top of the global quality, there needs to be a setting file for the variant.
   The file name is `variants/flsun_v400_<variant>.inst.cfg`.  
   The settings in these file are specific to the variant, but are independent of all quality or material settings.  
   Variants can be whatever machine detail you want to choose, commonly this is used for different nozzle sizes.
3. The third layer is the quality, material and variant specific settings in
   `quality/<material>/<variant>/flsun_v400_<variant>_<material>_<quality>_Quality.inst.cfg` 

All three files must exist for the profile to work and be correctly displayed inside Cura.

Optionally, there can be even more modifications of settings in intent files. They are stored in the intents folder with the name
`intent/<material>/flsun_v400_<variant>_<material>_<quality>_<intent>.inst.cfg`.
This file can modify settings that are only relevant for specific intents. Examples for intents are
- Dimensional accuracy
- Visual Quality
- Smooth Surface
- etc.
