//
//  UITestingBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import SwiftUI

final class UITestingBootcampViewModel: ObservableObject {
    let placeholder: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool = false

    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcamp: View {
    @StateObject private var viewModel = UITestingBootcampViewModel()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ZStack {
                if viewModel.currentUserIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }

                if !viewModel.currentUserIsSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

#Preview {
    UITestingBootcamp()
}

extension UITestingBootcamp {
    private var signUpLayer: some View {
        VStack {
            TextField(viewModel.placeholder, text: $viewModel.textFieldText)
                .font(.headline)
                .padding()
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))

            Button {
                withAnimation(.spring) {
                    viewModel.signUpButtonPressed()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20, content: {
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Show Welcome Alert")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.red)
                        .clipShape(.rect(cornerRadius: 10))
                })
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }

            })
            .alert("Welcome to the app", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
