#!/usr/bin/env bash

ANDROID_SDK_FILENAME=android-sdk_r23.0.1-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

apt-get update
apt-get install -y openjdk-8-jdk openjdk-8-jre
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
npm install -g ionic cordova
curl -O $ANDROID_SDK
tar -xzf $ANDROID_SDK_FILENAME
sudo chown -R ubuntu android-sdk-linux/
npm config set bin-links false -g

echo "ANDROID_HOME=~/android-sdk-linux" >> /home/ubuntu/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/ubuntu/.bashrc

expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-22,build-tools-22.0.1
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'
