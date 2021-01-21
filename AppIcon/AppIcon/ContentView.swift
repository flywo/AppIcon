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
                Spacer()
            }
            HStack {
                TextField(TextTools.Path, text: $path)
                    .padding()
                    .disabled(true)
                Button(TextTools.Choice) {
                    
                }.padding()
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
                Button(TextTools.iPad) {
                    guard checkError() else {
                        return
                    }
                    choiceDevice = TextTools.iPad
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
                Spacer()
                Button(TextTools.Mac) {
                    guard checkError() else {
                        return
                    }
                    choiceDevice = TextTools.Mac
                    alertShow.toggle()
                }.background(Color.green.cornerRadius(5))
            }.padding()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .alert(isPresented: $alertShow) { () -> Alert in
                Alert(title: Text(TextTools.AlertTitle),
                      message: Text(TextTools.AlertMSG1 + choiceDevice + TextTools.AlertMSG2),
                      primaryButton: .default(Text(TextTools.Sure),
                                              action: {
                                                  
                                              }),
                      secondaryButton: .default(Text(TextTools.Cancel)))
            }
            .alert(isPresented: $errorAlertShow) { () -> Alert in
                Alert(title: Text(TextTools.AlertTitle),
                      message: Text(errorMSG),
                      dismissButton: .default(Text(TextTools.Sure)))
            }
    }
}


extension ContentView {
    
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
