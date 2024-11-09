//
//  UIViewControllerReprentableBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 1.01.2024.
//

import SwiftUI

struct UIViewControllerReprentableBootcamp: View {
    @State private var show: Bool = false
    @State private var image: UIImage? = nil

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Button {
                show.toggle()
            } label: {
                Text("Click")
            }
        }
        .sheet(isPresented: $show, content: {
            //   BasicUIViewControllerReprentable(labelText: "Hello")
            UIImagePickerControllerReprentable(image: $image, showScreen: $show)
        })
    }
}

#Preview {
    UIViewControllerReprentableBootcamp()
}

struct BasicUIViewControllerReprentable: UIViewControllerRepresentable {
    let labelText: String

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyFirstViewController(labelText: labelText)
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct UIImagePickerControllerReprentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var showScreen: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }

    // From SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return
            }
            image = newImage
            showScreen = false
        }
    }
}

final class MyFirstViewController: UIViewController {
    let labelText: String

    init(labelText: String) {
        self.labelText = labelText
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .blue
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        view.addSubview(label)
        label.frame = view.frame
    }
}
