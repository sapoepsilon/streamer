# streamer
Yet another subsonic client


This project is a Flutter application that can be integrated with Figma and VSCode.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install) <br />
* [Unix Shell](https://github.com/sapoepsilon/Streamer/edit/main/README.md#unix-shell)<br />
* [VSCode](https://code.visualstudio.com/) (or [Android Studio](https://developer.android.com/studio))<br />
* A running [Subsonic server](http://www.subsonic.org/pages/index.jsp) (can be self-hosted or accessed via a remote server)<br />
* Subsonic API credentials (username and password)<br />

Clone the repository<br />
```
git clone https://github.com/sapoepsilon/Streamer.git
```


Get your Figma API key from Figma API website and add it to the project
Open the project in VSCode
Install the required packages by running
```
flutter packages get
```

Run the project on an emulator or device by pressing F5 or using the command
Copy code
```
flutter run
```

Built With

[Flutter](https://flutter.dev/) - The mobile app development framework<br />
[Figma](https://www.figma.com/) - Design tool used for UI/UX design<br />
[VSCode](https://www.figma.com/) - Code editor used for development<br />

### Authors
[sapooepsilon](https://github.com/sapoepsilon)
## Unix shell
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




## Acknowledgments

[Flutter documentation](https://docs.flutter.dev) - For development using Flutter

