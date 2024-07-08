//
//  ImageDownloader.swift
//  GitSearchBooks
//
//  Created by ByungHoon Ann on 6/13/24.
//


import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    static let shared = ImageLoader()
    
    private var cancellable: AnyCancellable?

    func loadImage(isbn: String) {
        if let cachedImage = ImageCache.shared.imageObject(imageName: isbn) {
            self.image = cachedImage
            return
        }

        cancellable = BookImageRequest.requestBookImage(isbn: isbn)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error loading image: \(error)")
                    self.image = nil  // 실패 시 UI에 반영
                }
            }, receiveValue: { [weak self] imageData in
                guard let self = self, let imageData = imageData, !imageData.isEmpty else {
                    self?.image = nil  // 빈 데이터 처리
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        ImageCache.shared.setDiskCache(imageName: isbn, imageData: imageData)  // 유효한 데이터에 대한 캐싱
                        self.image = image
                    } else {
                        self.image = nil 
                    }
                }
            })
    }

    deinit {
        cancellable?.cancel()
    }
}
