//
//  XlsGenerator.swift
//  i18nHelper
//
//  Created by Chen Defore on 2019/4/30.
//  Copyright © 2019 IGG. All rights reserved.
//

import Cocoa

typealias ExecuteResult = (isSuccess: Bool, executeResult: String?)
class XlsGenerator: NSObject {
    static let shared = XlsGenerator()
    
    func generateLocalizedFiles(xlsFilePath: String, outputPath: String) -> ExecuteResult {
        guard let convertTool = Bundle.main.path(forResource: "LocalizableBack", ofType: "py") else { return (false, nil)}
        let shell = "python \(convertTool) -f \(xlsFilePath) -t \(outputPath)"
        return runCommand(shell, needAuthorize: false)
    }
}

private func runCommand(_ command: String, needAuthorize: Bool) -> ExecuteResult {
    let script = needAuthorize ? "do shell script \"\(command)\"  with administrator privileges" : "do shell script \"\(command)\""
    let appleScript = NSAppleScript(source: script)
    
    var error: NSDictionary? = nil
    let result = appleScript!.executeAndReturnError(&error)
    if let error = error {
        print("执行 \n\(command)\n命令出错:")
        print(error)
        return (false, nil)
    }
    
    return (true, result.stringValue)
}
