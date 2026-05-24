#!/bin/bash
# decode_all.sh - Decode all obfuscated SWF assets, then decompile
set -e

FFDEC="java -jar D:/GitHub/XinTianyu-Sky/ZMXY_Flash/tools/ffdec_15.0.0/ffdec.jar"
DECODER="D:/GitHub/XinTianyu-Sky/ZMXY_Flash/build/zmxy_decoder_v2.exe"
GAME="D:/software/Game/zmxy3/造梦西游3再续天庭0.85"
OUT="D:/GitHub/XinTianyu-Sky/ZMXY_Flash/decompiled"
TEMP="D:/GitHub/XinTianyu-Sky/ZMXY_Flash/build/temp_swf_decode"

rm -rf "$TEMP"
mkdir -p "$TEMP"

decode_and_export() {
    local swf_path="$1"
    local rel_path="$2"
    local out_dir="$OUT/$rel_path"
    local tmp_file="$TEMP/${rel_path//\//_}.swf"

    # Copy and decode
    cp "$swf_path" "$tmp_file"
    echo 0 | "$DECODER" "$tmp_file" > /dev/null 2>&1

    # Decompile
    mkdir -p "$out_dir"
    $FFDEC -export script,image,sound "$out_dir" "$tmp_file" 2>&1 | tail -1
}

echo "=== Decoding + Decompiling all SWFs ==="
echo ""

# --- Core modules ---
echo "[Core modules]"
for f in 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 20 21 22 30 43 44 45 46 53 98 99 116; do
    swf="$GAME/assets/$f.swf"
    [ -f "$swf" ] && decode_and_export "$swf" "core/$f"
done

# --- Date modules ---
echo "[Date modules]"
for f in 20120117 20120119 20120203 20120808; do
    swf="$GAME/assets/$f.swf"
    [ -f "$swf" ] && decode_and_export "$swf" "core/$f"
done

# --- System SWFs ---
echo "[Systems]"
for f in pet1 MagicWeapon MagicWeapon2 EndlessMode ThreeBothers Role1Effect SD1; do
    swf="$GAME/assets/$f.swf"
    [ -f "$swf" ] && decode_and_export "$swf" "systems/$f"
done

# --- UI SWFs ---
echo "[UI]"
for f in Common1 StageCommon EIcon1 EIcon2 mouse backpack1 shop past hdDoor jifenActivity sgzz OtherMat1 Otherzm; do
    swf="$GAME/assets/$f.swf"
    [ -f "$swf" ] && decode_and_export "$swf" "ui/$f"
done

# --- SpecialUI ---
echo "[SpecialUI]"
for f in WuKong TangSeng BaJie ShaShen; do
    swf="$GAME/assets/SpecialUI/$f.swf"
    [ -f "$swf" ] && decode_and_export "$swf" "characters/${f}_UI"
done

# --- Characters (images only) ---
echo "[Characters]"
for f in WuKong TangSeng BaJie ShaShen; do
    swf="$GAME/assets/$f.swf"
    if [ -f "$swf" ]; then
        tmp="$TEMP/char_$f.swf"
        cp "$swf" "$tmp"
        echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
        mkdir -p "$OUT/characters/$f"
        $FFDEC -export image "$OUT/characters/$f" "$tmp" 2>&1 | tail -1
    fi
done

# --- Monsters (images only) ---
echo "[Monsters]"
for f in Monster1000 Monster1007 Monster1008 Monster1111 Monster47 Monster60; do
    swf="$GAME/assets/$f.swf"
    if [ -f "$swf" ]; then
        tmp="$TEMP/mon_$f.swf"
        cp "$swf" "$tmp"
        echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
        mkdir -p "$OUT/monsters/$f"
        $FFDEC -export image "$OUT/monsters/$f" "$tmp" 2>&1 | tail -1
    fi
done

# --- Equipment (images only) ---
echo "[Equipment]"
for swf in "$GAME/assets/cs_zb/"*.swf; do
    name=$(basename "$swf" .swf)
    tmp="$TEMP/eq_$name.swf"
    cp "$swf" "$tmp"
    echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
    mkdir -p "$OUT/equipment/$name"
    $FFDEC -export image "$OUT/equipment/$name" "$tmp" 2>&1 | tail -1
done

# --- Music (sound only) ---
echo "[Music]"
swf="$GAME/assets/Music.swf"
if [ -f "$swf" ]; then
    tmp="$TEMP/Music.swf"
    cp "$swf" "$tmp"
    echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
    mkdir -p "$OUT/music"
    $FFDEC -export sound "$OUT/music" "$tmp" 2>&1 | tail -1
fi

# --- Fonts ---
echo "[Fonts]"
swf="$GAME/assets/fonts.swf"
if [ -f "$swf" ]; then
    tmp="$TEMP/fonts.swf"
    cp "$swf" "$tmp"
    echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
    mkdir -p "$OUT/fonts"
    $FFDEC -export font "$OUT/fonts" "$tmp" 2>&1 | tail -1
fi

# --- Levels ---
echo "[Levels]"
for swf in "$GAME/assets/levels/"*.swf; do
    name=$(basename "$swf" .swf)
    tmp="$TEMP/level_$name.swf"
    cp "$swf" "$tmp"
    echo 0 | "$DECODER" "$tmp" > /dev/null 2>&1
    mkdir -p "$OUT/levels/$name"
    $FFDEC -export script,image "$OUT/levels/$name" "$tmp" 2>&1 | tail -1
done

echo ""
echo "=== Done! ==="
echo "Output: $OUT"
