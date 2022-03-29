# FolderOrganizer
A simple way of organizing your Finder Folders.
Currently wonking on MacOS 10.12 and above.

## Installation
There are two ways of installing FolderOrganizing

### Cloning the repo

1. Clone the repository
2. Build the package with `swift build -c release`
3. Go to: `FolderOrganizer/.build/release`
4. Put the executable `folder-organizer` on `usr/local/bin`
5. Open the terminal and run `folder-organizer -h`

### Using Homebrew:

1. run on terminal: `brew tap otavioalbucosta/FolderOrganizer`
2. run: `brew install FolderOrganizer`
3. Test the installation running `folder-organizer -h`

## Usage:
The common way to use is: 
```zsh
folder-organizer <subcommand>
```

Currently there are three commands: 

* ### organize 
```zsh
folder-organizer organize [--folder <folder>]
```
Organizes the folder using a JSON config file as pattern. If you want to organize an specific folder, use the flag `-f` and put the entire folder path. 
The program already has a presetted config with some popularly used formats as showed below:
```json
    {
  "Movies" : ["mp4", "mov", "avi"],
  "Documents" : ["pdf", "txt", "docx", "doc", "paper"],
  "Pictures" : ["jpeg", "jpg", "png", "gif", "svg"],
  "Music" : ["mp3", "ogg", "wav"]
}
```
Using this config file as pattern, the `organize` command moves files to their respective folder(key) by format(values). If the folder has the same file on both folders, it won't be moved.
Examples: 

```
➜  ~ folder-organizer organize
File IMG_BEE92E1DCC56-1.jpeg moved to /Users/otavioalbuquerque/Pictures
File HfuZqQd.jpeg moved to /Users/otavioalbuquerque/Pictures
File Screen Shot 2022-03-04 at 10.59.51.png moved to /Users/otavioalbuquerque/Pictures
File helen-winkle.jpg moved to /Users/otavioalbuquerque/Pictures
File lyn-slater.jpg moved to /Users/otavioalbuquerque/Pictures
File Vould.pdf moved to /Users/otavioalbuquerque/Documents
File designthinking.pdf moved to /Users/otavioalbuquerque/Documents
File Dia2_guiaensinohibrido.pdf moved to /Users/otavioalbuquerque/Documents
File ChallengePresentation.pdf moved to /Users/otavioalbuquerque/Documents
File Software_Guide.pdf moved to /Users/otavioalbuquerque/Documents
File IMG_0009.MOV moved to /Users/otavioalbuquerque/Movies
File IMG_0018.MOV moved to /Users/otavioalbuquerque/Movies
File IMG_0017.MOV moved to /Users/otavioalbuquerque/Movies
File IMG_0016.MOV moved to /Users/otavioalbuquerque/Movies
File IMG_0005.MOV moved to /Users/otavioalbuquerque/Movies
Finished
➜  ~ 
```

* ### manage-format
```zsh
folder-organizer manage-format
```
Edits the file formats on the config file, adding/removing a file format on a selected folder.
This command will ask first the folder name that you want to edit their designated formats.
The difference between adding and removing is the format imput. If you want to add a format, type the new format name you want to add. If you want to remove, just type the format name you want to remove.
Examples:

* #### Add
```
➜  ~ folder-organizer manage-format
This is a list of available folders and their respective filetypes:
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Music : mp3 ogg wav 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Documents : pdf txt docx doc paper 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Pictures : jpeg png gif svg jpg 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Movies : mov avi mp4 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
3D Models : 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Write the folder you want to add or remove formats. (if you want a new folder, leave this 
entry empty and use the command "folder-organizer manage-folder"):  
~ Music
Write the file format you want to add. If you want to remove, write an already existant file formant.
~ raw
Format .raw successful added on Music
➜  ~  
```
* #### Remove

```
➜  ~ folder-organizer manage-format
This is a list of available folders and their respective filetypes:
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Music : mp3 ogg wav raw
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Documents : pdf txt docx doc paper 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Pictures : jpeg png gif svg jpg 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Movies : mov avi mp4 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
3D Models : 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Write the folder you want to add or remove formats. (if you want a new folder, leave this 
entry empty and use the command "folder-organizer manage-folder"):  
~ Music
Write the file format you want to add. If you want to remove, write an already existant file formant.
~ raw
Format .raw sucessful removed from Music
➜  ~ 
```
* ### manage-format
```zsh
folder-organizer manage-folder
```
Add/remove the folders on the config file. If you want to add, type the new folder name, if the folder don't exists it will be created on your `/Users/<yourUsername>/` folder.
If you want to remove, just type the foldername you want to remove(you will lose all of your format configs for that folder, but the folder
won't be excluded).
Examples:

* #### Add
```
➜  ~ 
This is a list of available folders and their respective filetypes:
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Movies : mov avi mp4 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Music : mp3 ogg wav 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Documents : pdf txt docx doc paper 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Pictures : jpeg png gif svg jpg 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Write the folder name on your home folder you want to add. If the folder doesn't exist, it will be created on your home user folder. Write the name of 
an existant folder and it will be removed from the configs, but it won't be deleted on Mac.
~ 3D Models
Folder successfully added. Now you can add formats to that folder with "folder-organizer manage-format" command
➜  ~ 
```
* #### Remove
```
➜  ~ 
This is a list of available folders and their respective filetypes:
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Pictures : jpeg png gif svg jpg 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Documents : pdf txt docx doc paper 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Movies : mov avi mp4 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Music : mp3 ogg wav 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
3D Models : 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Write the folder name on your home folder you want to add. If the folder doesn't exist, it will be created on your home user folder. Write the name of 
an existant folder and it will be removed from the configs, but it won't be deleted on Mac.
~ 3D Models
Folder 3D Models removed.
➜  ~ 
```
