#!/usr/local/Cellar/bash/4.4.23/bin/bash

# couldn't use OSX's default bash as it's only 3.x and doesn't support ASSOCIATIVE ARRAYS

# create an associative array
declare -A countries

# call a rest api that returns json list of all countries and their capitals
for country in `lynx --dump 'https://restcountries.eu/rest/v2/all?fields=name;capital' | jq -r '.[]| @base64'`
do
  # store results in array using country as key and capital as value
  countries[$(echo $country | base64 --decode | jq -r .name)]=$(echo $country | base64 --decode | jq -r .capital)
done

# print out the results (could have used declare -p but preferred fotmatted output)
for country in "${!countries[@]}"
do
  echo "Country: $country"
  echo "Capital: ${countries[$country]}"
  echo --
done
