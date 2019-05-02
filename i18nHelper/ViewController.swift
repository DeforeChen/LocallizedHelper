//
//  ViewController.swift
//  i18nHelper
//
//  Created by Chen Defore on 2019/4/11.
//  Copyright © 2019 Defore. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var xlsFilePath: NSTextField!
    @IBOutlet weak var outputPath: NSTextField!
    @IBOutlet var consoleArea: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func chooseXlsFile(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.title = "选择 XLS 地址"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.becomeKey()
        let result = openPanel.runModal()
        if result == .OK, let filePath = openPanel.url?.path {
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath), filePath.hasSuffix("xls") {
                xlsFilePath.stringValue = filePath
            } else {
                FNHUD.showMessage("不是有效的 Excel 文件", in: view)
            }
        }
    }
    
    @IBAction func chooseOutputPath(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.title = "选择输出路径"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = false
        openPanel.becomeKey()
        let result = openPanel.runModal()
        if result == .OK, let filePath = openPanel.url?.path {
            outputPath.stringValue = filePath
        }
    }
    
    
    @IBAction func outputConvertResult(_ sender: Any) {
        guard xlsFilePath.stringValue.count > 0, outputPath.stringValue.count > 0 else {
            FNHUD.showMessage("路径不能为空", in: view)
            return
        }
        
        consoleArea.string = ""
        let result = XlsGenerator.shared.generateLocalizedFiles(xlsFilePath: xlsFilePath.stringValue,
                                                                outputPath: outputPath.stringValue)
        if result.isSuccess {
            consoleArea.string = result.executeResult ?? ""
            showCornfirmAlert("转化成功")
        } else {
            FNHUD.showError("转化失败,请查看日志", in: view)
        }
    }
    
    private func showCornfirmAlert(_ message: String) {
        let alert: NSAlert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "确定")

        alert.beginSheetModal(for: view.window!, completionHandler: nil)
    }
}


