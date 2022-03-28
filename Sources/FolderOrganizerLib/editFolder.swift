//
//  editFile.swift
//
//
//  Created by Otávio Albuquerque on 11/03/22.
//

import Foundation
import ArgumentParser



    public struct editFolder: ParsableCommand {
        public static var configuration: CommandConfiguration {
            .init(
                commandName: "manage-folder",
                abstract: "Create or remove folders to the system"
            )
        }
        
        public init() {}
        
        func loadJSON(filename: String, path: URL) throws -> [String:Array<String>]? {
            let fullpath = path.appendingPathComponent(filename)
            let data = try Data(contentsOf: fullpath)
            let JSONdata = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? Dictionary<String, [String]>
            return JSONdata as [String: [String]]?
        }
        
        func saveJSON(JSONObject:Any,filename:String, path:URL) throws{
            let fullpath = path.appendingPathComponent(filename)
            let data = try JSONSerialization.data(withJSONObject:JSONObject, options: [.prettyPrinted])
            try data.write(to: fullpath, options: .atomic)
        }
        
        public func run() throws {
            try createConfigJSON()
            
            let fmanager = FileManager.default
            let homeURL = fmanager.homeDirectoryForCurrentUser
            let configURL = homeURL.appendingPathComponent("Documents/.FolderOrganizer")
            
            let config = try loadJSON(filename: "config.json", path: configURL)
            
            print("This is a list of available folders and their respective filetypes:")
            
            if var configs = config {
                print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
                for (key,values) in configs{
                    print("\(key) : ", terminator: "")
                    for value in values {
                        print("\(value)", terminator: " ")
                    }
                    print()
                    print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-", terminator: "\n")
                }
                
                print("Write the folder name on your home folder you want to add. If the folder doesn't exist, it will be created on your home user folder. Write the name of \nan existant folder and it will be removed from the configs, but it won't be deleted on Mac.")
                let foldername = readLine()
                if foldername == "" {return}
                if let foldername = foldername {
                    for (key, _) in configs{
                        if key.lowercased() == foldername.lowercased(){
                            configs.removeValue(forKey: key)
                            print("Folder \(key) removed.")
                            try saveJSON(JSONObject: configs, filename: "config.json", path: configURL)
                            return
                        }
                    }
                    try fmanager.createDirectory(at: homeURL.appendingPathComponent(foldername.capitalized, isDirectory: true), withIntermediateDirectories: true, attributes: nil)
                    configs[foldername] = []
                    try saveJSON(JSONObject:configs, filename: "config.json", path: configURL)
                    print("Folder successfully added. Now you can add formats to that folder with \"folder-organizer manage-format\" command")
                    
                }
            }
            
            
            
            
        }
    }

