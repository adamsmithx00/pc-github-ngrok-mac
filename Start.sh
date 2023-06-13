#!/bin/bash
sudo mdutil -i off -a

#Create new account
sudo dscl . -create /Users/TheDisala
sudo dscl . -create /Users/TheDisala UserShell /bin/bash
sudo dscl . -create /Users/TheDisala RealName The_Disala_YT
sudo dscl . -create /Users/TheDisala UniqueID 1001
sudo dscl . -create /Users/TheDisala PrimaryGroupID 80
sudo dscl . -create /Users/TheDisala NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/TheDisala @#Disala123456
sudo dscl . -passwd /Users/TheDisala @#Disala123456
sudo createhomedir -c -u TheDisala > /dev/null
sudo dscl . -append /Groups/admin GroupMembership username

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

echo @#Disala123456 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#Start & Down Ngrok TCP Tunnel
brew install --cask ngrok
ngrok authtoken $1
ngrok tcp 5900 --region=in &
