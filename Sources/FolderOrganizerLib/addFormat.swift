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
            let fullpath = path.appendingPathComponent(filename)
            let data = try Data(contentsOf: fullpath)
            let JSONdata = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? Dictionary<String, [String]>
            return JSONdata as [String: [String]]?
        }
        func saveJSON(JSONObject:Any, filename:String, path:URL) throws{
            let fullpath = path.appendingPathComponent(filename)
            let data = try JSONSerialization.data(withJSONObject: JSONObject, options: [.prettyPrinted])
            try data.write(to: fullpath, options: .atomic)
        }
        
        public func run() throws {
            try createConfigJSON()
            
            let fmananger = FileManager.default
            let configURL = fmananger.homeDirectoryForCurrentUser.appendingPathComponent("Documents/.FolderOrganizer")
            
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
                        let fileformat = readLine()
                        if var fileformat = fileformat {
                            fileformat = fileformat.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ".", with: "")
                            if fileformat == ""{return}
                            if value.contains(fileformat){
                                configs[key]!.removeAll(where: {$0 == fileformat})
                                print("Format .\(fileformat) sucessful removed from \(key)")
                            }else{
                                
                                for (key, values) in configs{
                                    for value in values{
                                        if fileformat == value{
                                            print("You format is on another folder config, you want to change location? (y/n)")
                                            let ans = readLine()
                                            if ans == "y" || ans == "Y"{
                                                configs[key]!.removeAll(where: {$0 == fileformat})
                                            }else{
                                                print("Process aborted.")
                                                return
                                            }
                                        }
                                    }
                                }
                                configs[key]!.append(fileformat)
                                print("Format .\(fileformat) successful added on \(key)")
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

