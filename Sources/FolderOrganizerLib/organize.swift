//
//  Add.swift
//  
//
//  Created by Otávio Albuquerque on 09/03/22.
//

import Foundation
import ArgumentParser




    public struct Organize: ParsableCommand {
        public static var configuration: CommandConfiguration {
            .init(
                commandName: "organize",
                abstract: "Fully move the files to their folder according to their type"
            )
        }
        
        @Option(name: .shortAndLong, help: "the folder full path (if not included, the downloads folder will be organized")
        var folder: String?
        
        public init() {}
        
        func createConfig(){
            
        }
        
        func loadJSON(filename: String, path: URL) throws -> [String:Array<String>]? {
            let fullPath = path.appendingPathComponent(filename)
            let data = try Data(contentsOf: fullPath)
            let JSONdata = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? Dictionary<String, [String]>
            return JSONdata as [String: [String]]?
        }
        
        public func run() throws {
            try createConfigJSON()
            
            let fileManager = FileManager.default
            let commonPath = fileManager.homeDirectoryForCurrentUser

            let configPath = commonPath.appendingPathComponent("Documents/.FolderOrganizer")
            
            let config = try loadJSON(filename: "config.json", path: configPath)
            var folderPath: URL
            if let path = folder {
                folderPath = URL(fileURLWithPath: path)
                
                if try !folderPath.resourceValues(forKeys: [.isDirectoryKey]).isDirectory! {
                    print("Your path is not a folder path, please try again.")
                }
                
            } else{
                folderPath = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
            }
            
            if let conf = config {
                let contents = try fileManager.contentsOfDirectory(at: folderPath, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles])
                for (key, value) in conf{
                    for filetype in value {
                        let filter = try contents.filter({(path: URL) throws -> Bool in
                            return path.pathExtension.lowercased() == filetype
                            
                        })
                                                     
                                for url in filter {
                                    if fileManager.contentsEqual(atPath: url.path, andPath: commonPath.appendingPathComponent(key).appendingPathComponent(url.lastPathComponent).path){
                                        print("This file exists on both folders, it will not be moved")
                                        
                                        continue }
                                    try fileManager.createDirectory(at: commonPath.appendingPathComponent(key), withIntermediateDirectories: true, attributes: nil)
                                    try fileManager.moveItem(at: url , to: commonPath.appendingPathComponent(key).appendingPathComponent(url.lastPathComponent))
                                    print("File \(url.lastPathComponent) moved to \(commonPath.appendingPathComponent(key).path)")
                            }
                    }
                }
                print("Finished")
            }
        }
    }
