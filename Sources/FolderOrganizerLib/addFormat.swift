//
//  File.swift
//  
//
//  Created by Otávio Albuquerque on 11/03/22.
//

import Foundation
import ArgumentParser



   public struct addFormat: ParsableCommand {
        public static var configuration: CommandConfiguration {
            .init(
                commandName: "manage-format",
                abstract: "Add file format to a folder"
            )
        }
        
       public init() {}
        
        func loadJSON(filename: String, path: URL) throws -> [String:Array<String>]? {
            let fullPath = path.appendingPathComponent(filename)
            let data = try Data(contentsOf: fullPath)
            let JSONdata = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? Dictionary<String, [String]>
            return JSONdata as [String: [String]]?
        }
        func saveJSON(JSONObject:Any, filename:String, path:URL) throws{
            let fullPath = path.appendingPathComponent(filename)
            let data = try JSONSerialization.data(withJSONObject: JSONObject, options: [.prettyPrinted])
            try data.write(to: fullPath, options: .atomic)
        }
        
        public func run() throws {
            try createConfigJSON()
            
            let fileManager = FileManager.default
            let configURL = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Documents/.FolderOrganizer")
            
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
                print("Write the folder you want to add or remove formats. (if you want a new folder, leave this entry empty and use the command \"folder-organizer manage-folder\"):  ")
                let res = readLine()
                if res == "" { return }
                for (key, value) in configs{
                    if res?.lowercased() == key.lowercased(){
                        print("Write the file format you want to add. If you want to remove, write an already existant file formant.")
                        let fileFormat = readLine()
                        if var fileFormat = fileFormat {
                            fileFormat = fileFormat.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ".", with: "")
                            if fileFormat == ""{return}
                            if value.contains(fileFormat){
                                configs[key]!.removeAll(where: {$0 == fileFormat})
                                print("Format .\(fileFormat) sucessful removed from \(key)")
                            }else{
                                
                                for (key, values) in configs{
                                    for value in values{
                                        if fileFormat == value{
                                            print("You format is on another folder config, you want to change location? (y/n)")
                                            let ans = readLine()
                                            if ans == "y" || ans == "Y"{
                                                configs[key]!.removeAll(where: {$0 == fileFormat})
                                            }else{
                                                print("Process aborted.")
                                                return
                                            }
                                        }
                                    }
                                }
                                configs[key]!.append(fileFormat)
                                print("Format .\(fileFormat) successful added on \(key)")
                            }
                            
                            try saveJSON(JSONObject: configs, filename: "config.json", path: configURL)
                            return
                        }
                    }
                    
                    
                }
                print("You didn't write an available folder. If you want to add a new folder to the configs, try the manage-folder command.")
                return
            }
        }
    }

