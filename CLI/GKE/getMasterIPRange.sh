#!/bin/bash

gcloud projects list | grep PROJECT_ID | cut -d : -f 2 | sed 's/ //' | xargs > projectlist

for project in $(cat projectlist); do 
    gcloud container clusters list --project "$project" |  grep "NAME\|LOCATION" > clusterNameLocation
    cat clusterNameLocation | grep NAME | cut -d : -f 2 | sed 's/ //' | xargs > clusterName
    cat clusterNameLocation | grep LOCATION | cut -d : -f 2 | sed 's/ //' | xargs > clusterLocation
    for clusterName in $(cat clusterName); do
        for clusterLocation in $(cat clusterLocation); do
            masterIPrange=`gcloud container clusters describe "$clusterName" --project "$project" --zone "$clusterLocation" | grep masterIpv4CidrBlock`
            echo "$project" ----- "$clusterName" ---- "$masterIPrange"
        done
    done
done
