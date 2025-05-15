#!/bin/bash

################################
## Script to change an EC2 Tag
## into something else
##
## By: Shlomo Dubrowin
## Date: May 15, 2025
################################

################################
## Variables
################################
REGION=""
TMP1="/tmp/$( basename "$1" ).1.tmp"

################################
## Functions
################################
function Help {
                echo -e "\n\tusage: $( basename "$0") [ -h | --help ] [ -r | --region <region: us-east-2> ] [ -o | --old-tag <Case Sensitive Tag Name> ] [ -n | --new-tag <Case Sensitive Tag Name> ]\n"
                exit 1
}

################################
## CLI Options
################################

if [ -z $1 ]; then
        Help
fi
if [ -z != "$1" ]; then
        while [ "$1" != "" ]; do
        case $1 in
                -o | --old-tag )
                        shift
			OLD="$1"
			echo "Old Tag is: $OLD"
                        ;;
		-n | --new-tag )
			shift
			NEW="$1"
			echo "New Tag is: $NEW"
			;;	
                -r | --region )
                        shift
                        REGION="--region $1"
                        echo "Using $REGION"
                        ;;      
                *)
                        Help
                        ;;
        esac
        shift
        done
fi
if [ -z $OLD ] || [ -z $NEW ]; then
        Help
fi

################################
## Main Code
################################

# First, find all instances with the lowercase "project" tag and create the new "Project" tag
aws ec2 describe-instances \
	--filters "Name=tag-key,Values=$OLD" \
	--query 'Reservations[].Instances[].[InstanceId]' \
	--output text > $TMP1

while read instance_id ; do
	project_value=`aws ec2 describe-instances --instance-id $instance_id --query "Reservations[0].Instances[0].Tags[?Key=='${OLD}'].Value" --output text`
	echo "Setting $instance_id ${NEW} to $project_value"
	aws ec2 create-tags \
	--resources "$instance_id" \
	--tags "Key=${NEW},Value=$project_value"
	echo "Removing $instance_id ${OLD}"
	aws ec2 delete-tags \
	--resources "$instance_id" \
	--tags "Key=${OLD}"

	echo "Updated tags for instance $instance_id"
done < /tmp/foo
_id" \
	--tags "Key=${OLD}"

	echo "Updated tags for instance $instance_id"
done < $TMP1
