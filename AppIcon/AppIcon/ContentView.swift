//
//  ContentView.swift
//  AppIcon
//
//  Created by yuhua on 2021/1/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = ""
    @State private var alertShow = false
    @State private var errorAlertShow = false
    @State private var choiceDevice = ""
    @State private var errorMSG = ""
    @State private var image: NSImage?
    @State private var dragOver = false
    
    var body: some View {
        VStack {
            Group {
                Text(TextTools.Tips)
                    .padding()
                Spacer()
                Image(nsImage: image ?? NSImage(named: "add")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                        showChoiceImagePanel()
                    }
                    .onDrop(of: ["public.file-url"], isTargeted: $dragOver, perform: { providers -> Bool in
                        providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                            if let data = data, let path = NSString(data: data, encoding: 4),
                               let url = URL(string: path as String) {
                                let image = NSImage(contentsOf: url)
                                self.image = image
                            }
                        })
                        return true
                    })
                    .alert(isPresented: $errorAlertShow) { () -> Alert in
                        Alert(title: Text(TextTools.AlertTitle),
                              message: Text(errorMSG),
                              dismissButton: .default(Text(TextTools.Sure)))
                    }
                Spacer()
            }
            HStack {
                Button(TextTools.OpenPath) {
                    openImagePath()
                }.background(Color.green.cornerRadius(5)).padding()
                TextField(TextTools.Path, text: $path)
                    .padding()
                    .disabled(true)
                Button(TextTools.Choice) {
                    showImageSavePanel()
                }.background(Color.green.cornerRadius(5)).padding()
            }
            HStack {
                Button(TextTools.iPhone) {
                    guard checkError() else {
                        return
                    }
                    choiceDevice = TextTools.iPhone
                    alertShow.toggle()
                }.background(Color.green.cornerRadius(5))
                Spacer()
                Button(TextTools.iMac) {
                    guard checkError() else {
                        return
                    }
                    choiceDevice = TextTools.iMac
                    alertShow.toggle()
                }.background(Color.green.cornerRadius(5))
                Spacer()
                Button(TextTools.iWatch) {
                    guard checkError() else {
                        return
                    }
                    choiceDevice = TextTools.iWatch
                    alertShow.toggle()
                }.background(Color.green.cornerRadius(5))
            }.padding()
            .alert(isPresented: $alertShow) { () -> Alert in
                Alert(title: Text(TextTools.AlertTitle),
                      message: Text(TextTools.AlertMSG1 + choiceDevice + TextTools.AlertMSG2),
                      primaryButton: .default(Text(TextTools.Sure),
                                              action: {
                                                if choiceDevice == TextTools.iPhone {
                                                    saveIPhoneIcon()
                                                } else if choiceDevice == TextTools.iMac {
                                                    saveMACIcon()
                                                } else if choiceDevice == TextTools.iWatch {
                                                    saveWatchIcon()
                                                }
                                              }),
                      secondaryButton: .default(Text(TextTools.Cancel)))
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}


extension ContentView {
    
    func saveIPhoneIcon() {
        saveIcon(sizes: IconSizeModel.iOSSizes)
    }
    
    func saveMACIcon() {
        saveIcon(sizes: IconSizeModel.macOSSizes)
    }
    
    func saveWatchIcon() {
        saveIcon(sizes: IconSizeModel.watchOSSizes)
    }
    
    func saveIcon(sizes: [IconSizeModel]) {
        if !FileManager.default.fileExists(atPath: path, isDirectory: nil) {
            try? FileManager.default.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: true, attributes: nil)
        }
        for index in 0 ..< sizes.count {
            let item = sizes[index]
            image?.resize(width: item.width(), height: item.width()).save(path+item.name())
        }
    }
    
    /// 检查是否选择图片和路径
    /// - Returns: 结果
    func checkError() -> Bool {
        if image == nil {
            errorMSG = TextTools.NoImage
            errorAlertShow.toggle()
            return false
        }
        if path.isEmpty {
            errorMSG = TextTools.NoPath
            errorAlertShow.toggle()
            return false
        }
        return true
    }
    
    /// 打开文件夹
    func openImagePath() {
        if path.isEmpty {
            errorMSG = TextTools.NoPath
            errorAlertShow.toggle()
            return
        }
        NSWorkspace.shared.open(URL(fileURLWithPath: path))
    }
    
    /// 弹出图片选择框
    func showChoiceImagePanel() {
        let dialog = NSOpenPanel()
        dialog.message = TextTools.ChoiceImageMSG
        dialog.canChooseFiles = true
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["png", "jpg", "bmp", "jpeg"]
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            if let url = dialog.url {
                choiceImage(url: url)
            }
        }
    }
    
    /// 弹出图片保存路径选择框
    func showImageSavePanel() {
        let dialog = NSOpenPanel()
        dialog.message = TextTools.ChoiceImageSavePath
        dialog.canChooseFiles = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.prompt = TextTools.Sure
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            if let path = dialog.url?.absoluteString {
                self.path = path
            }
        }
    }
    
    /// 图片选择完毕
    /// - Parameter url: 图片URL
    func choiceImage(url: URL) {
        image = NSImage(byReferencingFile: url.path)!
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
