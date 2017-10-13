#!/bin/bash

if [ "$1" == "push" ]
then
    if [ ! -z "$2"]
     then
        adb shell am broadcast -a com.google.android.c2dm.intent.RECEIVE -c io.emma.emmaandroid -n io.emma.emmaandroid/io.emma.android.push.EMMAGCMBroadcastReceiver --es "eMMa" "1" --es "message" "Test_notification" --es "id" "$2" --es "url" "https://www.google.es" --es "richPicture" "http://www.tivix.com/uploads/blog_pics/Android-logo.png" --es "productId" "RULE1"
      else
        echo "Error: add id for push notification: Eg: push 1234"
      fi

    echo "IMPORTANT: Remove temporaraly : android:permission=\"com.google.android.c2dm.permission.SEND\" from push receiver"
elif [ "$1" == "broadcast" ]
then
     if [ ! -z "$2" ]
     then
        adb shell am broadcast -a "$2" -c io.emma.emmaandroid
      else
        echo "Error: action parameter is missing: Eg: broadcast com.package.action"
      fi
elif [ "$1" == "service" ]
then
    if [ ! -z "$2" -a "$2" == "refresh_token" ]
    then
        adb shell am startservice -a com.google.android.gms.iid.InstanceID -n io.emma.emmaandroid/io.emma.android.push.EMMAInstanceIDListenerService  --es "CMD" "RST"
    else
        echo "Error: action parameters is missing. Eg: service refresh_token"
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
              -> push <id>
              -> broadcast com.package.action
              -> deeplink emmaio://settings"
fi

