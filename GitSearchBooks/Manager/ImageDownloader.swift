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
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] imageData in
                guard let self = self, let imageData = imageData else { return }
                ImageCache
                    .shared
                    .setDiskCache(imageName: isbn,
                                  imageData: imageData)
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
    }

    deinit {
        cancellable?.cancel()
    }
}
