#!/bin/bash

CURRENT_DIR=$(realpath "$(dirname "$0")")
CURA_CONFIG_FOLDER="${HOME}/.local/share/cura/5.5"
CURA_INSTALL_FOLDER="/opt/ultimaker-cura"

if [ ! -e "${CURA_CONFIG_FOLDER}" ]; then
	echo "Cura folder not found! ${CURA_CONFIG_FOLDER}"
	exit 1
fi

set -e

# Disabling built in v400 proiles in cura
sudo find "${CURA_INSTALL_FOLDER}/share/cura/resources" -type f -iname 'flsun_v400*' -exec rm {} +

# Install definitions file
ln -sf "${CURRENT_DIR}/definitions/flsun_v400.def.json" "${CURA_CONFIG_FOLDER}/definitions/flsun_v400.def.json"

# Install extruder
ln -sf "${CURRENT_DIR}/extruders/flsun_v400_extruder_0.def.json" "${CURA_CONFIG_FOLDER}/extruders/flsun_v400_extruder_0.def.json"

# Install mesh
[ ! -d "${CURA_CONFIG_FOLDER}/meshes" ] && mkdir -p "${CURA_CONFIG_FOLDER}/meshes"
ln -sf "${CURRENT_DIR}/meshes/flsun_v400.stl" "${CURA_CONFIG_FOLDER}/meshes/flsun_v400.stl"

# Install global quality
ln -sf "${CURRENT_DIR}/quality/flsun_v400_global_Draft_Quality.inst.cfg" "${CURA_CONFIG_FOLDER}/quality/flsun_v400_global_Draft_Quality.inst.cfg"

# Install variants (nozzle sizes)
ln -sf "${CURRENT_DIR}/variants/flsun_v400_0.4.inst.cfg" "${CURA_CONFIG_FOLDER}/variants/flsun_v400_0.4.inst.cfg"

# Install material / variant quality
[ ! -d "${CURA_CONFIG_FOLDER}/quality/PLA/0.4" ] && mkdir -p "${CURA_CONFIG_FOLDER}/quality/PLA/0.4"
ln -sf "${CURRENT_DIR}/quality/PLA/0.4/flsun_v400_0.4_PLA_Draft_Print.inst.cfg" "${CURA_CONFIG_FOLDER}/quality/PLA/0.4/flsun_v400_0.4_PLA_Draft_Print.inst.cfg"
