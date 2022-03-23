//
//  File.swift
//  
//
//  Created by Otávio Albuquerque on 23/03/22.
//

import Foundation

public func createConfigJSON() throws{
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
    
    
    
}
