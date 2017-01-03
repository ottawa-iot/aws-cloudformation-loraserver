#!/bin/bash

location=$(aws s3api get-bucket-location --bucket $1)

regionString=''

if [[ $location =~ (\"(.*)\": \"(.*)\") ]]; then
    regionString=${BASH_REMATCH[3]}
fi

echo $regionString


