//  Created by Fauzi Sholichin on 23/02/2019.
//  Copyright © 2019 Fauzi Sholichin. All rights reserved.
//

import Foundation

let templateVIVMER = "VIVMER.xctemplate"

let destinationRelativePath = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application"

func printInConsole(_ message:Any){
    print("====================================")
    print("\(message)")
    print("====================================")
}

func moveTemplate(){

    let fileManager = FileManager.default
    let destinationPath = bash(command: "xcode-select", arguments: ["--print-path"]).appending(destinationRelativePath)
    do {
        if !fileManager.fileExists(atPath:"\(destinationPath)/\(templateVIVMER)"){
        
            try fileManager.copyItem(atPath: templateVIVMER, toPath: "\(destinationPath)/\(templateVIVMER)")
            
            printInConsole("✅  Architecture Kit VIVMER installed succesfully 🎉. Enjoy it 🙂")
            
        }else{
            
            try _ = fileManager.replaceItemAt(URL(fileURLWithPath:"\(destinationPath)/\(templateVIVMER)"), withItemAt: URL(fileURLWithPath:templateVIVMER))
            
            printInConsole("✅  Architecture Kit VIVMER already exists. So has been replaced succesfully 🎉. Enjoy it 🙂")
        }
    }
    catch let error as NSError {
        printInConsole("❌  Ooops! Something went wrong 😡 : \(error.localizedFailureReason!)")
    }
}

func shell(launchPath: String, arguments: [String]) -> String
{
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)!
    if output.count > 0 {
        //remove newline character.
        let lastIndex = output.index(before: output.endIndex)
        return String(output[output.startIndex ..< lastIndex])
    }
    return output
}

func bash(command: String, arguments: [String]) -> String {
    let whichPathForCommand = shell(launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
    return shell(launchPath: whichPathForCommand, arguments: arguments)
}

moveTemplate()
