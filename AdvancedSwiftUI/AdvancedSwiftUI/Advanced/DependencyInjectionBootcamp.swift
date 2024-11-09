//
//  DependencyInjectionBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import Combine
import SwiftUI

struct PostsModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

final class ProductionDataService: DataServiceProtocol {
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

final class MockDataService: DataServiceProtocol {
    let testData: [PostsModel]

    init(testData: [PostsModel]?) {
        self.testData = testData ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "One"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "Two")
        ]
    }

    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

final class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }

    private func loadPosts() {
        dataService.getData()
            .sink { _ in
            } receiveValue: { [weak self] posts in
                self?.dataArray = posts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    @StateObject var vm: DependencyInjectionViewModel

    init(dataService: DataServiceProtocol) {
        self._vm = StateObject(wrappedValue: .init(dataService: dataService))
    }

    var body: some View {
        ScrollView {
            LazyVStack(content: {
                ForEach(vm.dataArray, id: \.id) { post in
                    Text(post.title)
                }
            })
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    static let mockDataService = MockDataService(testData: nil)
    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)

    static var previews: some View {
        DependencyInjectionBootcamp(dataService: dataService)
    }
}

/*
 Bağımlılıklarınızı enjekte etmekdir. Kullanılacak yapıları init sayesinde yapıya enjekte etmek.
 */

/*
 Problems with SINGLETON
 1.
    *Signletons are global. Singleton sınıflar global scop'a sahiptir. Yani uygulama boyunca herhangi bir yerden erişilebilirler.
    *Çoklu iş parçacıklı uygulamalar kullanıyorsak ve kullanılan threadlar aynı anda bu shared örneğine erişmek istiyorsa büyük ölçekli projelerde uygulamanın çökmesine veya daha büyük sorunlara yol açabilir.
 2.
    *Can't customize the init. Init static olarak başlatıldığı için özelleştiremiyoruz.
 3.
    *Can't swap out dependencies. Protocol kullanarak uygulama içinde ve dışında bir şeyleri değiştirebiliriz. Ancak NetworkManager.shared. tarzında bir referans kullanıldığı için başka bir veri servisini kullanamayız.
 4.
    *Singleton kullanmamanın çözünü dependency injektion'dur.
    Referansı veri sınıfı içinde başlatmak yerine veri hizmetini oldukça erken başlatmak istiyoruz (neredeyse uygulama açıldığında) ve uygulama içine yerleştiriyoruz. Sonra bu veri hizmetinin gerekli olduğu yerlere enjekte ediyoruz.
 */
