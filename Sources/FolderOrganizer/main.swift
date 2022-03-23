import ArgumentParser
import Foundation
import FolderOrganizerLib

    struct Main: ParsableCommand {
        static var configuration: CommandConfiguration{
            .init(
                commandName: "folder-organizer",
                abstract: "Simple CLI to organize files by extension",
                version: "0.1.1",
                subcommands: [
                    FolderOrganizerLib.Organize.self,
                    FolderOrganizerLib.addFormat.self,
                    FolderOrganizerLib.editFolder.self
                    
                ]
            )
        }
    }




let fmanager = FileManager.default

let configpath = fmanager.homeDirectoryForCurrentUser.appendingPathComponent("Documents/.FolderOrganizer/config.json")
if !fmanager.fileExists(atPath: configpath.path){
    try fmanager.createDirectory(at: configpath.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
    let config: [String: [String]] = [
        "Documents": ["pdf","txt","docx","doc","paper"],
        "Movies": ["mp4","mov","avi"],
        "Pictures": ["jpeg","jpg","png","gif","svg"],
        "Music": ["mp3","ogg","wav"]
    ]
    let data = try JSONSerialization.data(withJSONObject: config, options: [.prettyPrinted])
    try data.write(to: configpath, options: [.atomic])
    
}

Main.main()

