#!/usr/bin/env bash

# Author: Michael Mathews Dec 2020
# Scrubs MarchWatch.com for market data
# using curl, grep, sed and shell syntax

# Documentation of where fiels are being downloaded
pwd
ls

# Prompt and read user for ticker symbols of stocks, saved as array
echo "ENTER TICKERS WITH SPACES BETWEEN"
read -a TICKERS


# MarketWatch Page
webpage=https://www.marketwatch.com/investing/stock/

# Create results file
touch results.txt

# loop through read tickers
for i in ${TICKERS[@]}
do
    echo "" >> results.txt  # new line
    echo "$i" >> results.txt
    curl "$webpage$i" > temp.txt
    # find in the text and add to results file
    cat temp.txt | grep "<small class=\"label\">Yield</small>" -A 1 >> results.txt
    cat temp.txt | grep "<small class=\"label\">Dividend</small>" -A 1 >> results.txt
    cat temp.txt | grep "<small class=\"label\">EPS</small>" -A 1 >> results.txt
    cat temp.txt | grep "<small class=\"label\">P/E Ratio</small>" -A 1 >> results.txt
done

# get rid of the extra formatting
sed -i -e 's/                    <small class="label">//g' results.txt
sed -i -e 's/\</small>//g' results.txt
sed -i -e 's/                    <span class="primary ">//g' results.txt
sed -i -e 's/\</span>//g' results.txt
# end
