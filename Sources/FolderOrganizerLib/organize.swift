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
        
        
        func loadJSON(filename: String, path: URL) throws -> [String:Array<String>]? {
            let fullpath = path.appendingPathComponent(filename)
            let data = try Data(contentsOf: fullpath)
            let JSONdata = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? Dictionary<String, [String]>
            return JSONdata as [String: [String]]?
        }
        
        public func run() throws {
            
            let fmananger = FileManager.default
            let commonpath = fmananger.homeDirectoryForCurrentUser

            let configpath = commonpath.appendingPathComponent("Documents/.FolderOrganizer")
            
            let config = try loadJSON(filename: "config.json", path: configpath)
            var folderpath: URL
            if let path = folder {
                folderpath = URL(fileURLWithPath: path)
                
                if try !folderpath.resourceValues(forKeys: [.isDirectoryKey]).isDirectory! {
                    folderpath = folderpath.deletingLastPathComponent()
                }
                
            } else{
                folderpath = fmananger.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
            }
            
            if let conf = config {
                let contents = try fmananger.contentsOfDirectory(at: folderpath, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles])
                for (key, value) in conf{
                    for filetype in value {
                        let filter = try contents.filter({(path: URL) throws -> Bool in
                            return path.pathExtension.lowercased() == filetype
                            
                        })
                                                     
                                for url in filter {
                                    if !fmananger.contentsEqual(atPath: url.path, andPath: commonpath.appendingPathComponent(key).appendingPathComponent(url.lastPathComponent).path){ continue }
                                    try fmananger.moveItem(at: url , to: commonpath.appendingPathComponent(key).appendingPathComponent(url.lastPathComponent))
                            }
                    }
                }
            }
        }
    }
