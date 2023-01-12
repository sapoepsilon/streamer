# streamer
Yet another subsonic client

<img width="851" alt="image" src="https://user-images.githubusercontent.com/47342870/211945081-9ae95fd4-35bd-486a-9d85-8cd4f4c362aa.png">


This project is a Flutter application that can be integrated with Figma and VSCode.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
[Join our teams channel](https://teams.microsoft.com/l/team/19%3a6yObTI8Wffsk6MSA_0HydZOZE7k-0EJMT58PbZJcAsg1%40thread.tacv2/conversations?groupId=53fe00c0-3a9a-49d9-9093-e20845cdce1d&tenantId=5a57404a-b412-4229-8d67-303fda6c124b)

## Prerequisites
* [Source Control](https://github.com/sapoepsilon/streamer#source-control)
* [Flutter SDK](https://docs.flutter.dev/get-started/install) <br />
* [Unix Shell](https://github.com/sapoepsilon/streamer/#unix-shell)<br />
* [VSCode](https://code.visualstudio.com/) (or [Android Studio](https://developer.android.com/studio))<br />
* A running [Subsonic server](http://www.subsonic.org/pages/index.jsp) (can be self-hosted or accessed via a remote server)<br />
* Subsonic API credentials (username and password)<br />
* [Teams](https://www.microsoft.com/en-us/microsoft-teams/download-app)
* [Figma](httos://www.figma.com/)

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

## Source Control

Source control, also known as version control, is a system that allows developers to keep track of changes made to the codebase of a project. It is an essential tool for software development, particularly when multiple people are working on the same codebase. Think of it like a notebook where all the changes made to the codebase are recorded.

Here are some popular Git clients for macOS and Windows, with links to their download pages:

### macOS
[GitHub Desktop](https://desktop.github.com/): This is a Git client that is developed by GitHub and is available for both macOS and Windows. It has a simple and easy-to-use interface and provides access to many of GitHub's features such as pull requests and issue tracking.
[SourceTree](https://www.sourcetreeapp.com/): This is a Git client developed by Atlassian. It has a powerful set of features and is popular among developers who work with Git on a daily basis.
[Tower](https://www.git-tower.com/mac): This is a commercial Git client for macOS that offers a visually appealing and intuitive interface. It is known for its powerful branching and merging capabilities and is often used by experienced Git users.
### Windows
[GitHub Desktop](https://desktop.github.com/): As mentioned before, also available for Windows
[SourceTree](https://www.sourcetreeapp.com/): also available for Windows. Available for free download on this page
[TortoiseGit](https://tortoisegit.org/download/): This is a popular Git client for Windows that is based on the TortoiseSVN client. It integrates seamlessly with Windows Explorer and has a simple, user-friendly interface. It's particularly useful for beginners and it's used widely.
Please keep in mind that these are just a few popular options, and there may be other Git clients that are suitable for your needs. It's always a good idea to try out a few different options and choose the one that works best for you.

## Figma
We will be using for UI changes. Feel free to make suggestions to our [mockup](https://www.figma.com/file/mNRohLimliXIuyFfmbxT50/Streamer?node-id=0%3A1&t=VYFrIuDYIeraD1np-1)

Learn [GIT](https://docs.github.com/en/get-started/quickstart/git-and-github-learning-resources)


## Acknowledgments

[Flutter documentation](https://docs.flutter.dev) - For development using Flutter

