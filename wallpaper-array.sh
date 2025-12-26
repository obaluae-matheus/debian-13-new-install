#!/bin/bash

echo ""

OUTPUT_DIR="$HOME/.striped"
mkdir -p "$OUTPUT_DIR"
echo "Output directory: $OUTPUT_DIR"
echo ""

if ! command -v convert &> /dev/null; then
    echo "ERROR: ImageMagick is not installed!"
    exit 1
fi

WIDTH=2500
HEIGHT=2500

# eye-friendly color pairs
COLOR_PAIRS=(
    "#D4C8B8|#BCA896|100|Warm_Sand"
    "#C8D4C8|#B0C0B0|120|Soft_Mint"
    "#C8C8D4|#B0B0C0|90|Gentle_Lavender"
    "#D4C8D0|#C0B0B8|110|Pale_Rose"
    "#C0D4D4|#A8C0C0|130|Cool_Aqua"
    "#D4D4C0|#C0C0A8|100|Cream_Yellow"
    "#C8D4C8|#B0C0B0|115|Sage_Green"
    "#D4C8D4|#C0B0C0|105|Soft_Mauve"
    "#C0D4D8|#A8C0C8|125|Light_Sky"
    "#D4D4C8|#C0C0B0|95|Warm_Gray"
    "#D4C8C8|#C0B0B0|110|Soft_Peach"
    "#C8D4C0|#B0C0A8|120|Light_Olive"
    "#D4C0D4|#C0A8C0|100|Pale_Orchid"
    "#C0C8D4|#A8B0C0|115|Periwinkle"
    "#D0D0D0|#B8B8B8|130|Pure_Light"
    "#C0D4CC|#A8C0B4|105|Seafoam"
    "#D4CCC0|#C0B4A8|110|Warm_Linen"
    "#CCC0D4|#B4A8C0|120|Misty_Lilac"
    "#C0D4D4|#A8C0C0|100|Frost_Blue"
    "#D4D4CC|#C0C0B4|125|Ivory_Cream"
    "#D4CCD4|#C0B4C0|95|Pale_Violet"
    "#CCD4C8|#B4C0B0|115|Morning_Dew"
    "#D4C8CC|#C0B0B4|105|Blush_Pink"
    "#C8CCD4|#B0B4C0|110|Powder_Blue"
    "#D4D4C8|#C0C0B0|120|Champagne"
    "#CCD4D4|#B4C0C0|100|Arctic_Mist"
    "#D4BCC8|#C0A4B0|110|Dusty_Rose"
    "#BCD4C8|#A4C0B0|105|Mint_Sage"
    "#C8BCD4|#B0A4C0|115|Soft_Purple"
    "#D4D4BC|#C0C0A4|125|Pale_Gold"
    "#BCD4D4|#A4C0C0|100|Teal_Mist"
    "#D4C8BC|#C0B0A4|120|Warm_Taupe"
    "#C8D4BC|#B0C0A4|95|Spring_Green"
    "#D4BCD4|#C0A4C0|110|Orchid_Haze"
    "#BCC8D4|#A4B0C0|105|Steel_Blue"
    "#D4D4D4|#BCBCBC|130|Soft_Silver"
    "#C0D4C0|#A8C0A8|115|Forest_Mist"
    "#D4C0C8|#C0A8B0|100|Mauve_Pink"
    "#C0C8C8|#A8B0B0|120|Slate_Gray"
    "#D4C8D8|#C0B0C8|110|Lilac_Dream"
    "#C8D8D4|#B0C8C0|105|Ocean_Breeze"
    "#D8C8C8|#C8B0B0|125|Rose_Beige"
    "#C8D8C8|#B0C8B0|95|Pale_Jade"
    "#C8C8D8|#B0B0C8|115|Lavender_Mist"
    "#D8D4C8|#C8C0B0|100|Wheat_Cream"
    "#C8D4D8|#B0C0C8|120|Sky_Pearl"
    "#D8C8D4|#C8B0C0|110|Plum_Haze"
    "#D0C8D8|#B8B0C8|105|Periwinkle_Dream"
    "#D8D0C8|#C8B8B0|115|Caramel_Mist"
    "#C8D8D0|#B0C8B8|125|Celadon"
    "#D8C8D0|#C8B0B8|100|Thistle_Gray"
)

SHUFFLED=($(shuf -e "${COLOR_PAIRS[@]}"))

for i in {1..15}; do
    # Parse color pair using pipe delimiter
    IFS='|' read -r BASE_COLOR STRIPE_COLOR STRIPE_WIDTH NAME <<< "${SHUFFLED[$((i-1))]}"

    DISPLAY_NAME="${NAME//_/ }"
    echo "Wallpaper $i: $DISPLAY_NAME"
    echo "  Base: $BASE_COLOR, Stripe: $STRIPE_COLOR, Width: $STRIPE_WIDTH"

    # Create the striped pattern using a simpler approach
    magick -size ${WIDTH}x${HEIGHT} xc:"$BASE_COLOR" \
        -fill "$STRIPE_COLOR" \
        -draw "$(for ((x=0; x<WIDTH; x+=STRIPE_WIDTH*2)); do echo "rectangle $x,0 $((x+STRIPE_WIDTH)),$HEIGHT"; done)" \
        "$OUTPUT_DIR/wall_${i}.png"

    echo ""
done

echo "Complete"
echo ""
