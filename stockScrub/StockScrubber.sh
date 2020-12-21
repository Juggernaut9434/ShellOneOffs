#!/usr/bin/env bash

# Author: Michael Mathews Dec 2020
# Scrubs MarchWatch.com for market data
# using curl, grep, sed and shell syntax

# Documentation of where files are being downloaded
pwd
ls

# Prompt and read user for ticker symbols of stocks, saved as array
echo "ENTER TICKERS WITH SPACES BETWEEN"    # ko wmt aapl msft 
read -a TICKERS


# MarketWatch Page
# This only works because the website has stock/ticker where ticker is "ko" or "wmt"
webpage=https://www.marketwatch.com/investing/stock/

# Create results file clean
echo "" > results.txt
echo "" > tickers.txt

# loop through read tickers, ${TICKERS[@]} == length of array. so `for i in 3` or `for i in 14`
for i in ${TICKERS[@]}
do
    echo "" >> results.txt  # new line
    echo "$i" >> tickers.txt
    curl "$webpage$i" -s > temp.txt
    # find in the text and add to results file
    cat temp.txt | grep "<small class=\"label\">Yield</small>" -A 1 >> results.txt
    cat temp.txt | grep "<small class=\"label\">EPS</small>" -A 1 >> results.txt
    cat temp.txt | grep "<small class=\"label\">P/E Ratio</small>" -A 1 >> results.txt
done

# get rid of the extra formatting
# for more on sed: 
# https://www.grymoire.com/Unix/Sed.html#uh-10a

# More clean up for single line
# tr is for characters and sed is for string matches
cat results.txt | tr -d [a-zA-Z\<\/\>\"=] | tr '\n' ',' | tr -d [:space:] | sed -e 's/,,,/,/' -e 's/,,/,/g' -e 's/,,/,\n,/g' > results.txt

# put ticker in front of the line
echo "" > temp.txt
c=1
for i in ${TICKERS[@]}
do
    cat results.txt | sed "$c s/^/$i/" | sed -n "${c}p" >> temp.txt
    ((c=c+1))   # increment counter
done
# put header on the csv
cat temp.txt | sed "1s/^/Ticker,Yield,EPS,PE,/" > results.csv
# clean up other files
rm tickers.txt temp.txt results.txt
# end
