#!/bin/bash
# Alex Pinch, created Aug 1st 2024
# usage: `bash make_html.sh observations-472964.csv`

# check if the CSV file is provided
if [ $# -ne 1 ]; then
    echo "Error: Incorrect usage. Include $0 <csv_file>"
    exit 1
fi

csv_file=$1
output_html="index.html"

# check if CSV exists
if [ ! -f "$csv_file" ]; then
    echo "Error: CSV file '$csv_file' not found."
    exit 1
fi

echo "<!DOCTYPE html>
<html>
<head>
    <title>Birds of Palestine</title>
</head>
<body>" > "$output_html"

# getting time
 date=$(date +"%B %d, %Y at %H:%M:%S")

# adding text
echo "<p>In order for me to write poetry that isn't political<br> 
I must listen to the birds<br> 
And in order to hear the birds<br> 
The warplanes must be silent<br>
-Marwan Makhoul<br><br>
All iNaturalist observations of birds in Palestine. Last updated $date</p><br>" >> "$output_html"

# Reading inat data from CSV, skipping empty images and adding links the images
awk -F ',' 'NR>1 && $14 != "" {print $13 "," $14}' "$csv_file" | while IFS=, read -r url image_url; do
    echo "<a href=\"$url\"><img src=\"$image_url\"></a>" >> "$output_html"
done

# closing HTML tags
echo "</body>" >> "$output_html"
echo "</html>" >> "$output_html"

echo "HTML generated: $output_html"
