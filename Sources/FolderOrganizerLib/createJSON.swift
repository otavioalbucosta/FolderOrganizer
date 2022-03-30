//
//  File.swift
//  
//
//  Created by Otávio Albuquerque on 23/03/22.
//

import Foundation

public func createConfigJSON() throws{
    let fileManager = FileManager.default

    let configPath = fileManager.homeDirectoryForCurrentUser.appendingPathComponent("Documents/.FolderOrganizer/config.json")
    if !fileManager.fileExists(atPath: configPath.path){
        try fileManager.createDirectory(at: configPath.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
        let config: [String: [String]] = [
            "Documents": ["pdf","txt","docx","doc","paper"],
            "Movies": ["mp4","mov","avi"],
            "Pictures": ["jpeg","jpg","png","gif","svg"],
            "Music": ["mp3","ogg","wav"]
        ]
        let data = try JSONSerialization.data(withJSONObject: config, options: [.prettyPrinted])
        try data.write(to: configPath, options: [.atomic])
        
    }
    
    
    
}
