# FolderOrganize
A simple way of organizing your Finder Folders.
Currently wonking on MacOS 10.12 and above.

## Installation
There are two ways of installing FolderOrganizing
1. Clone the repository
2. Build the package with `swift build -c release`
3. Go to: `FolderOrganizer/.build/release`
4. Put the executable `folder-organizer` on `usr/local/bin`
5. Open the terminal and run `folder-organizer -h`

## Usage:
The common way to use is: 
```bash
folder-organizer <subcommand>
```

Currently there are three commands: 

#### *organize 

Organizes the folder using a JSON config file as pattern. The program already has a presetted pattern as
showed below:
```json
    {
  "Movies" : ["mp4", "mov", "avi"],
  "Documents" : ["pdf", "txt", "docx", "doc", "paper"],
  "Pictures" : ["jpeg", "jpg", "png", "gif", "svg"],
  "Music" : ["mp3", "ogg", "wav"]
}
```
Using this config file as pattern, the `organize` command moves files to their respective folder(key) by format(values). If the folder has the same file on both folders, it won't be moved.

#### *manage-format



