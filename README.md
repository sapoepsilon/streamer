# streamer
This music player app, built with Flutter and designed with unique user interfaces for both Android and iOS, allows you to stream your entire music library using a Subsonic server. With its intuitive design and easy-to-use features, you can enjoy your music seamlessly on any device. The app is also fully compatible with Navidrome, so you can easily access your library and create playlists on the go.
<img width="851" alt="image" src="https://user-images.githubusercontent.com/47342870/211945081-9ae95fd4-35bd-486a-9d85-8cd4f4c362aa.png">


This project is a Flutter application that can be integrated with Figma and VSCode.

* [⚙️ Building locally](https://github.com/sapoepsilon/streamer#installation)
* [⬇️ Prerequisites](https://github.com/sapoepsilon/streamer#prerequisites)
* [🍃 Flutter SDK](https://docs.flutter.dev/get-started/install) <br />
* [🐚 Unix Shell](https://github.com/sapoepsilon/streamer/#unix-shell)<br />
* Download - coming soon...<br />
 <a href="git pull --rebase origin main"> Join our Discord<img src="https://raw.githubusercontent.com/sapoepsilon/streamer/main/lib/readme/discord_icon.png" alt="Join our discord" width="21px"/></a><br />
## Prerequisites
* [Source Control](https://github.com/sapoepsilon/streamer#source-control)
* [Flutter SDK](https://docs.flutter.dev/get-started/install) <br />
* [Unix Shell](https://github.com/sapoepsilon/streamer/#unix-shell)<br />
* [VSCode](https://code.visualstudio.com/) (or [Android Studio](https://developer.android.com/studio))<br />
* A running [Subsonic server](http://www.subsonic.org/pages/index.jsp) (can be self-hosted or accessed via a remote server)<br />
* [Figma](httos://www.figma.com/)

# Installation

Make sure that preruquistes have been met. Run in terminal:

```
flutter doctor
```


### Example output: <br />
>✅ Flutter (Channel stable)<br />
✅ Android toolchain - develop for Android devices <br />
✅ Xcode - develop for iOS and macOS <br />
✅ Chrome - develop for the web<br />
✅ Android Studio (version 2022.1)<br />
✅ IntelliJ IDEA Ultimate Edition (version 2022.3.1)<br />
✅ VS Code (version 1.75.1)<br />
✅ HTTP Host Availability<br />

Clone the repository<br />
```
git clone https://github.com/sapoepsilon/Streamer.git
```
Open the project in VSCode
Install the required packages by running
```
flutter packages get
```

Run the project on an emulator or device by pressing F5 or using the command
```
flutter run
```


### Authors
[sapooepsilon](https://github.com/sapoepsilon)<br />
[dereckAn](https://github.com/dereckAn)<br />
On macOS, the Unix shell is already installed by default. You can access it through the Terminal application, which can be found in the "Utilities" folder within the "Applications" 
folder.

On Windows, you will need to install a Unix shell environment in order to use a Unix shell. One popular option is the Windows Subsystem for Linux (WSL), which allows you to run 
Linux distributions on Windows. Here are the steps to set up WSL on Windows:

1. Make sure that your version of Windows is at least version 1709, and that it is 64-bit. You can check this by going to Settings > System > About.<br />
2. Enable the Windows Subsystem for the Linux feature. This can be done by opening the PowerShell as administrator and running the following command:<br />
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
3. Restart your computer when prompted.
4. Visit the Microsoft Store and install a Linux distribution, such as Ubuntu.
5. After installation, open the Linux distribution and follow the prompts to set up a user account.

You will now be able to run Linux commands within the newly installed shell and you can access the shell by opening the Windows start menu, and searching for the Linux distribution 
you installed.

Note that for some advanced functionality, you might want to consider using a Unix terminal emulator such as Cygwin or Git Bash. They will provide you some of the functionality from 
a Unix/Linux shell, but it may not be as complete or up-to-date as with a full WSL setup.

## Source Control

Source control, also known as version control, is a system that allows developers to keep track of changes made to the codebase of a project. It is an essential tool for software development, particularly when multiple people are working on the same codebase. Think of it like a notebook where all the changes made to the codebase are recorded.

Here are some popular Git clients for macOS and Windows, with links to their download pages:

### macOS
[GitHub Desktop](https://desktop.github.com/): This is a Git client that is developed by GitHub and is available for both macOS and Windows. It has a simple and easy-to-use interface and provides access to many of GitHub's features such as pull requests and issue tracking.<br />
[SourceTree](https://www.sourcetreeapp.com/): This is a Git client developed by Atlassian. It has a powerful set of features and is popular among developers who work with Git on a daily basis.<br />
[Tower](https://www.git-tower.com/mac): This is a commercial Git client for macOS that offers a visually appealing and intuitive interface. It is known for its powerful branching and merging capabilities and is often used by experienced Git users.<br />
### Windows
[GitHub Desktop](https://desktop.github.com/): As mentioned before, also available or Windows
<br />
[SouceTree](https://www.sourcetreeapp.com/): also available for Windows. Available for free download on this page <br />
[TortoiseGit](https://tortoisegit.org/download/): This is a popular Git client for Windows that is based on the TortoiseSVN client. It integrates seamlessly with Windows Explorer and has a simple, user-friendly interface. It's particularly useful for beginners and it's used widely.<br />
Please keep in mind that these are just a few popular options, and there may be other Git clients that are suitable for your needs. It's always a good idea to try out a few different options and choose the one that works best for you.

## Figma
We will be using for UI changes. Feel free to make suggestions to our [mockup](https://www.figma.com/file/mNRohLimliXIuyFfmbxT50/Streamer?node-id=0%3A1&t=VYFrIuDYIeraD1np-1)

Learn [GIT](https://docs.github.com/en/get-started/quickstart/git-and-github-learning-resources)


## Acknowledgments

[Flutter documentation](https://docs.flutter.dev) - For development using Flutter

