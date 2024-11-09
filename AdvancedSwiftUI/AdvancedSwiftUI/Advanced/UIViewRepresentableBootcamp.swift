//
//  UIViewRepresentableBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 1.01.2024.
//

import SwiftUI

/// Convert a UIView view to SwiftUI
struct UIViewRepresentableBootcamp: View {
    @State private var text: String = ""
    var body: some View {
        VStack {
            Text(text)
            HStack {
                Text("SwiftUI")
                TextField("Type here...", text: $text)
                    .frame(width: .infinity, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 12))
            }
            HStack {
                Text("UIKit")
                UITextFieldViewRepresentable(
                    text: $text)
                    .updatePlaceholder("Messi")
                    .frame(width: .infinity, height: 55)
                    .background(.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeHolder: String
    let placeHolderColor: UIColor
    
    init(text: Binding<String>, placeHolder: String = "Default placeholder...", placeHolderColor: UIColor = .red) {
        self._text = text
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(
            string: placeHolder,
            attributes: [
                .foregroundColor: placeHolderColor,
                
            ])
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    /// Placeholder'i değiştirme
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeHolder = text
        return viewRepresentable
    }
    
    /// From SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    /// From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
