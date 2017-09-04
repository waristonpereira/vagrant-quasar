#!/usr/bin/env bash

ANDROID_SDK_FILENAME=android-sdk_r23.0.1-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

apt-get update
apt-get install -y openjdk-8-jdk openjdk-8-jre lib32stdc++6 lib32z1 expect unzip
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
npm install -g quasar-cli cordova
curl -O $ANDROID_SDK
tar -xzf $ANDROID_SDK_FILENAME -C /home/ubuntu/
sudo npm config set bin-links false -g

sudo mkdir /opt/gradle
sudo wget https://services.gradle.org/distributions/gradle-3.4.1-bin.zip
sudo unzip -d /opt/gradle gradle-3.4.1-bin.zip

echo "PATH=\$PATH:/opt/gradle/gradle-3.4.1/bin" >> /home/ubuntu/.bashrc
echo "ANDROID_HOME=~/android-sdk-linux" >> /home/ubuntu/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/ubuntu/.bashrc

mkdir /home/ubuntu/.android/
touch /home/ubuntu/.android/repositories.cfg

wget --quiet --output-document=tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
unzip -oqq tools.zip -d /home/ubuntu/android-sdk-linux

expect -c '
set timeout -1   ;
spawn /home/ubuntu/android-sdk-linux/tools/bin/sdkmanager "platform-tools" "platforms;android-22" "build-tools;22.0.1" --sdk_root=/home/ubuntu/android-sdk-linux/ 
expect {
    "ccept" { exp_send "y\r" ; exp_continue }
    eof
}
'
expect -c '
set timeout -1   ;
spawn /home/ubuntu/android-sdk-linux/tools/bin/sdkmanager --licenses --sdk_root=/home/ubuntu/android-sdk-linux/ 
expect {
    "ccept" { exp_send "y\r" ; exp_continue }
    eof
}
'
