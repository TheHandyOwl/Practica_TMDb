//
//  DetailAssembly.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 30/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

final class DetailAssembly {
	private let imageLoadingAssembly: ImageLoadingAssembly
    private let navigationController: UINavigationController

	init(imageLoadingAssembly: ImageLoadingAssembly,
         navigationController: UINavigationController) {
		self.imageLoadingAssembly = imageLoadingAssembly
        self.navigationController = navigationController
	}

	func detailHeaderPresenter() -> DetailHeaderPresenter {
		return DetailHeaderPresenter(imageRepository: imageLoadingAssembly.imageRepository)
	}

	func posterStripPresenter() -> PosterStripPresenter {
		return PosterStripPresenter(imageRepository: imageLoadingAssembly.imageRepository)
	}
    
    func detailNavigator() -> DetailNavigator {
        // Se devolverá el DetailNavigation en función del tipo de dispositivo
        // Se puede delegar a una factoría para centralizar estas decisiones
        // Por ahora es único
        return PhoneDetailNavigator(navigationController: navigationController,
                               viewControllerProvider: self)
    }
}

extension DetailAssembly: DetailViewControllerProvider {
    // FIXME_ Temporary!!
    private class DummyFakeDetailPresenter: DetailPresenter {
        var view: DetailView?
        func didLoad() { }
        func didSelect(item: PosterStripItem) { }
    }
    
    func detailViewController(identifier: Int64, mediaType: MediaType) -> UIViewController {
        return DetailViewController(presenter: DummyFakeDetailPresenter(),
                                    headerPresenter: detailHeaderPresenter(),
                                    posterStripPresenter: posterStripPresenter())
    }    
}
