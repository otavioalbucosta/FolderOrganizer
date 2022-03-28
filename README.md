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

#### organize 
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

#### manage-format
Edits the file formats on the config file, adding/removing a file format on a selected folder.
This command will ask first the folder name that you want to edit their designated formats.
The difference between adding and removing is the format imput. If you want to add a format, type the new format name you want to add. If you want to remove, just type the format name you want to remove.
Example:
```bash
➜  ~ folder-organizer manage-format
This is a list of available folders and their respective filetypes:
Pictures : jpeg png gif svg jpg 
Documents : pdf txt docx doc paper 
3D Models : 
Movies : mov avi mp4 
Music : mp3 ogg wav 
Write the folder you want to add or remove formats. (if you want a new folder, leave this entry empty and use the command "folder-organizer manage-folder"):  
Music
Write the file format you want to add. If you want to remove, write an already existant file formant.
raw
Format .raw successful added on Music
➜  ~  
```
