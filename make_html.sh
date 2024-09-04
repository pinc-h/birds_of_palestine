#!/bin/bash
# Alex Pinch, lasted edited Aug 1st 2024
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

# adding text, opening div for the images below
echo "<h1>Birds of Palestine</h1>" >> "$output_html"
echo "<p>All iNaturalist observations of birds in Palestine in the last year. Last updated Sept 4th 2024.</p><br>" >> "$output_html"

# Reading inat data from CSV, skipping empty images and adding links the images
awk -F ',' 'NR>1 && $14 != "" {print $13 "," $14}' "$csv_file" | while IFS=, read -r url image_url; do
    echo "<a href=\"$url\"><img src=\"$image_url\"></a>" >> "$output_html"
done

# closing HTML tags
echo "</body>" >> "$output_html"
echo "</html>" >> "$output_html"

echo "HTML generated: $output_html"
