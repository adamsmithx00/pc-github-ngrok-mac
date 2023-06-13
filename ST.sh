#!/bin/bash
sudo mdutil -i off -a

#Create account
sudo dscl . -create /Users/Jahid
sudo dscl . -create /Users/Jahid UserShell /bin/bash
sudo dscl . -create /Users/Jahid RealName Jahid_Hasan
sudo dscl . -create /Users/Jahid UniqueID 1001
sudo dscl . -create /Users/Jahid PrimaryGroupID 80
sudo dscl . -create /Users/Jahid NFSHomeDirectory /Users/tcv
sudo dscl . -passwd /Users/Jahid @#Jahid123456
sudo dscl . -passwd /Users/Jahid @#Jahid123456
sudo createhomedir -c -u Jahid > /dev/null
sudo dscl . -append /Groups/admin GroupMembership username

#Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

echo @#Jahid123456 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Start VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#Start ngrok TCP
brew install --cask ngrok
ngrok authtoken $1
ngrok tcp 5900 --region=in &
