title=My steps to setup elementaryOS Freya
date=2015-03-27
author=Angel Ruiz
type=post
tags=linux, elementaryOS, guide
status=published
~~~~~~

<a href="https://elementary.io/" target="_blank">
![elementary os](img/elementary-os-icon.png) 
</a>

I have decided to give a go to the latest release of the [elementaryOS Linux distribution](https://elementary.io/), **Freya**, and see if it can become my distro of choice for software development. Main reason being that: elementary OS is essentially a Ubuntu (14.04 in this case) based Linux system that just works but wrapped in a really beautiful, smooth and minimalistic interface. All its features make the elementary os usage experience to stand out from all the other Linux distributions I have tried. Even the command line terminal has its own personality, definitely contributing as a differentiation factor.

<div class="index-break"></div>

You only have to boot the OS once and after 4 to 5 seconds (I am using a SSD) you instantly feel atracted to the aesthetics of the desktop. Then after a few minutes using it, everything: the screen transitions, the animations, the notifications, ... makes a delight to your eyes and leaves you with a pleasant sense of lightness and responsiveness. Give it a go and you'll see that the praises don't stop with the looks :-)

So far I have been using it in a VM with good results, so I am going to leave here all the steps I followed in order to get it ready for "business" in my laptop after I finished the standard installation process:

### Using "oduso" to install many desktop applications automatically
They have a wide range of common used apps available like web browsers ,text editors and many others... 

Just go to their website and choose the apps, icons sets, themes and options you want: https://oduso.com/

It will then generate a unique url and give you the command that needs to be executed to start the automatic installation process:

Mine for instance is:
```
wget -O - oduso.com/dt2r.sh | bash
```

### Install Linuxbrew:
* Website: https://github.com/Homebrew/linuxbrew
* Installation:

```
sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
```

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
```

Add this to `.bashrc` or `.profile`:
```
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
```

### Install JDK 8
* Original guide: http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
* Installation:
```
su -
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer
exit
```

* Modify `.profile` to add `JAVA_HOME` system variable and set bin folder inside the `PATH` variable:
```
export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
export PATH=$PATH:$JAVA_HOME/bin
```


### Install GVM
* Website: http://gvmtool.net/
* Installation:
```
curl -s get.gvmtool.net | bash
source "~/.gvm/bin/gvm-init.sh"
```

### Install Maven
* Website: http://maven.apache.org/
* Installation:
```
brew install maven
```

### Install Git
* Website: http://git-scm.com/
* Installation:
```
brew install git
```

### Install IntellijIDEA
* Website: https://www.jetbrains.com/idea/
* Original guide: http://askubuntu.com/questions/272314/setup-and-install-intellij-with-jdk
* Installation:
 * Download latest release from website: https://www.jetbrains.com/idea/download/
 * Extract content: 
```
tar -zxvf Downloads/ideaIU-xxx.tar.gz
```
 * Move ideaIU-xxx folder to `/opt/idea`:
```
$ sudo mv idea-IU-xxx/ /opt/idea
```
 * Create symlink inside `/usr/local/bin` to `/opt/idea/bin/idea.sh`:
```
sudo ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea
```
 * Create file `idea.desktop` with the following content:
```
[Desktop Entry]
Name=IntelliJ IDEA
Type=Application
Exec=idea
Terminal=false
Icon=idea
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE;
Name[en]=IntelliJ IDEA 
```
 * Install previus file:
```
sudo desktop-file-install idea.desktop
```
 * Install icon so it is displayed in the menu:
```
sudo cp /opt/idea/bin/idea.png /usr/share/pixmaps/idea.png
```

### Install Applications menu editor "MenuLibre"

* Website: http://smdavis.us/projects/menulibre/
* Original guide: http://eos-snippets.blogspot.com.au/2014/02/menu-editor-menulibre.html
* Installation:

```
sudo apt-add-repository ppa:versable/elementary-update
sudo apt-get update
sudo apt-get install menulibre

```

### Install Microsoft fonts
* Installation:
```
sudo apt-get install ttf-mscorefonts-installer
```

### Install Skype
* Website: http://www.skype.com/en/download-skype/skype-for-computer/
* Original guide: http://linuxg.net/skype-4-3-is-now-available-via-the-canonical-partner-repository-for-ubuntu-14-04-and-ubuntu-12-04-installation-instructions/
* Installation:
```
sudo add-apt-repository "deb http://archive.canonical.com/ trusty partner"
sudo apt-get update
sudo apt-get install skype
```