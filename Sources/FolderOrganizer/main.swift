import ArgumentParser
import Foundation
import FolderOrganizerLib

    public struct Main: ParsableCommand {
        public static var configuration: CommandConfiguration{
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
        public init(){
            
        }
        

    }




try FolderOrganizerLib.createConfigJSON()

Main.main()

