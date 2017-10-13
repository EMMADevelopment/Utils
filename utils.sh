#!/bin/bash

if [ "$1" == "push" ]
then
    adb shell am broadcast -a com.google.android.c2dm.intent.RECEIVE -c io.emma.emmaandroid -n io.emma.emmaandroid/io.emma.android.push.EMMAGCMBroadcastReceiver --es "eMMa" "1" --es "message" "Test_notification" --es "id" "123443432" --es "url" "https://www.google.es" --es "richPicture" "http://www.tivix.com/uploads/blog_pics/Android-logo.png" --es "productId" "RULE1"

    echo "IMPORTANT: Remove temporaraly : android:permission=\"com.google.android.c2dm.permission.SEND\" from push receiver"
elif [ "$1" == "broadcast" ]
then
     if [ ! -z "$2" ]
     then
        adb shell am broadcast -a "$2" -c io.emma.emmaandroid
      else
        echo "Error: action parameter is missing: Eg: broadcast com.package.action"
      fi

elif [ "$1" == "deeplink" ]
then
    if [ ! -z "$2" ]
    then
        adb shell am start -a android.intent.action.VIEW -d "$2" io.emma.emmaandroid
    else
        echo "Error: deeplink string parameters is missing. Eg: deeplink emmaio://settings"
    fi
else
    echo "Usage:
              -> push test
              -> broadcast broadcast com.package.action
              -> deeplink emmaio://settings"
fi

