#!/bin/bash
echo "Download from s3://$1 to $2"
region=$(./getRegionForBucket.sh $1)
s3cmd=""
if [[ -z $region ]]; then
	s3cmd="aws s3 cp s3://$1 $2 --recursive"
else
	s3cmd="aws s3 cp s3://$1 $2 --recursive --region $region"
fi

echo "Running command $s3cmd"

eval "$s3cmd"

