#!/usr/bin/env bash

ANDROID_SDK_FILENAME=android-sdk_r23.0.1-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

sudo apt-get update
sudo apt-get install -y openjdk-8-jdk openjdk-8-jre
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g ionic cordova
sudo curl -O $ANDROID_SDK
sudo tar -xzf $ANDROID_SDK_FILENAME
sudo chown -R ubuntu android-sdk-linux/
sudo npm config set bin-links false -g

sudo mkdir /opt/gradle
sudo wget https://services.gradle.org/distributions/gradle-3.4.1-bin.zip
sudo apt-get install -y unzip
sudo unzip -d /opt/gradle gradle-3.4.1-bin.zip

echo "PATH=\$PATH:/opt/gradle/gradle-3.4.1/bin" >> /home/ubuntu/.bashrc
echo "ANDROID_HOME=~/android-sdk-linux" >> /home/ubuntu/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/ubuntu/.bashrc

sudo apt-get install -y expect

expect -c '
set timeout -1   ;
spawn /home/ubuntu/android-sdk-linux/tools/android update sdk --no-ui --all --filter platform-tool,android-22,build-tools-22.0.1
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'

sudo wget --quiet --output-document=tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
sudo unzip -qq tools.zip -d ~/android-sdk-linux

expect -c '
set timeout -1   ;
spawn /home/ubuntu/android-sdk-linux/tools/bin/sdkmanager --licenses --sdk_root=/home/ubuntu/android-sdk-linux/ 
expect {
    "ccepted" { exp_send "y\r" ; exp_continue }
    eof
}
'

sudo apt-get -y install lib32stdc++6 lib32z1

sudo chown -R ubuntu android-sdk-linux/
