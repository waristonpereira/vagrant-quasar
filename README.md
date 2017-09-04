# vagrant-quasar
VagrantBox for VirtualBox

Ready-to-go hybrid development environment for building mobile apps with Quasar, Cordova, and Android.

Fork from https://github.com/waristonpereira/vagrant-ionic/ but based on http://quasar-framework.org

### Installation


To install, download and install [Vagrant](https://www.vagrantup.com/downloads.html) for your platform, then download and install [VirtualBox](http://virtualbox.org/).

Once Vagrant and VirtualBox are installed, you can download the latest release of this GitHub repo, and unzip it. `cd` into the unzipped folder and run:

```bash
$ vagrant up
$ vagrant ssh
```

The username for vagrant is `ubuntu`. Run your commands using `sudo`. 

Your shared folder is `/quasar-projects` connected to local folder inside directory of vagrant files.

This will download and install the image, and then go through the dependencies and install them one by one. `vagrant ssh` will connect you to the image and give you a bash prompt. Once everything completes, you'll have a working box to build your apps on Android.

### Connected Android Devices

The image also has support for connected USB Android devices. To test whether devices are connected, you can run (from the box):

```bash
$ sudo /home/ubuntu/android-sdk-linux/platform-tools/adb devices
```

If that does not work, or shows `????? permissions`, then run:

```bash
sudo /home/ubuntu/android-sdk-linux/platform-tools/adb kill-server
sudo /home/ubuntu/android-sdk-linux/platform-tools/adb start-server
```
