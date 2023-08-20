#!/bin/bash

CURRENT_DIR=$(realpath "$(dirname "$0")")
CURA_FOLDER="${HOME}/.local/share/cura/5.4"

if [ ! -e "${CURA_FOLDER}" ]; then
	echo "Cura folder not found! ${CURA_FOLDER}"
	exit 1
fi

set -e

# Install definitions file
ln -sf "${CURRENT_DIR}/definitions/flsun_v400.def.json" "${CURA_FOLDER}/definitions/flsun_v400.def.json"

# Install extruder
ln -sf "${CURRENT_DIR}/extruders/flsun_v400_extruder_0.def.json" "${CURA_FOLDER}/extruders/flsun_v400_extruder_0.def.json"

# Install mesh
ln -sf "${CURRENT_DIR}/meshes/flsun_v400.stl" "${CURA_FOLDER}/extruders/flsun_v400.stl"
