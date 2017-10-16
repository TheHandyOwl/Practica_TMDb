//
//  FeaturedPresenter.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 27/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol FeaturedView: class {
    var title: String? { get set }
    
	func setShowsHeaderTitle(_ title: String)
	func setMoviesHeaderTitle(_ title: String)

	func update(with shows: [Show])
	func update(with movies: [Movie])
}

final class FeaturedPresenter {
    private let detailNavigator: DetailNavigator
    private let repository: FeaturedRepositoryProtocol
    private let disposeBag = DisposeBag()
    
	weak var view: FeaturedView?
    
    init(detailNavigator: DetailNavigator,
         repository: FeaturedRepositoryProtocol) {
        self.detailNavigator = detailNavigator
        self.repository = repository
    }
    
	func didLoad() {
        view?.title = NSLocalizedString("FEATURED", comment: "")
        view?.setShowsHeaderTitle(NSLocalizedString("ON TV", comment: ""))
		view?.setMoviesHeaderTitle(NSLocalizedString("IN THEATERS", comment: ""))

		//addFakeContent()
        loadContents()
	}

	func didSelect(show: Show) {
		// TODO: implement
        detailNavigator.showDetail(withIdentifier: show.identifier, mediaType: .show)
	}

	func didSelect(movie: Movie) {
		// TODO: implement
        detailNavigator.showDetail(withIdentifier: movie.identifier, mediaType: .movie)
	}
}

private extension FeaturedPresenter {
    func loadContents() {
        // Traemos los datos de shows y movies, pero nos quedamos los 3 primeros
        let showsOnTheAir = repository.showsOnTheAir()
            .map { $0.prefix(3) }
        let moviesNowPlaying = repository.moviesNowPlaying(region: Locale.current.regionCode!)
            .map { $0.prefix(3) }
        
        // Espera a tener los 2 datos y entonces ejecutará el closure
        Observable.combineLatest(showsOnTheAir, moviesNowPlaying) { shows, movies in
            return (shows, movies) // Devolvemos una tupla con ambos datos combinados. Tupla de ArraySlice y ArraySlice
            }.observeOn(MainScheduler.instance) // Volvemos al principal para pintamos!!!
            .subscribe(onNext: { [weak self] shows, movies in // El [weak self] es para evitar referencias circulares por si las moscas
                // Como es una referencia débil podemos no tenerla
                /*
                 guard let presenter = self else {
                 return
                 }
                 // No deja como ArraySlice
                 // self.view?.update(with: shows)
                 // self.view?.update(with: movies)
                 // Sí deja como Array
                 self?.view?.update(with: Array(shows))
                 self?.view?.update(with: Array(movies))
                 // Presenter no es una referencia débil
                 presenter.view?.update(with: Array(shows))
                 presenter.view?.update(with: Array(movies))
                 */
                
                // Pero tiramos de truco para seguir usando self
                guard let `self` = self else {
                    return
                }
                // Aquí estamos tirando de truco
                self.view?.update(with: Array(shows))
                self.view?.update(with: Array(movies))
                
            })
            .disposed(by: disposeBag)
        
    }
}

//FakeDataContent
/*
private extension FeaturedPresenter {
	func addFakeContent() {
		let shows = [
			Show(identifier: 1413,
			     title: "American Horror Story",
			     posterPath: "/gwSzP1cJL2HsBmGStN2vOg3d4Qd.jpg",
			     backdropPath: "/anDMMvgVV6pTNSxhHgiDPUjc4pH.jpg",
			     firstAirDate: "2012-01-20",
			     genreIdentifiers: [18, 9648])
		]

		view?.update(with: shows)

		let movies = [
			Movie(identifier: 330459,
			      title: "Rogue One: A Star Wars Story",
			      posterPath: "/qjiskwlV1qQzRCjpV0cL9pEMF9a.jpg",
			      backdropPath: "/tZjVVIYXACV4IIIhXeIM59ytqwS.jpg",
			      releaseDate: "2016-11-20",
			      genreIdentifiers: [28, 12, 878]),
			Movie(identifier: 297762,
			      title: "Wonder Woman",
			      posterPath: "/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg",
			      backdropPath: "/hA5oCgvgCxj5MEWcLpjXXTwEANF.jpg",
			      releaseDate: "2017-05-20",
			      genreIdentifiers: [28, 12, 14, 878]),
			Movie(identifier: 324852,
			      title: "Despicable Me 3",
			      posterPath: "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg",
			      backdropPath: "/7YoKt3hzTg38iPlpCumqcriaNTV.jpg",
			      releaseDate: "2017-08-20",
			      genreIdentifiers: [12, 16, 35]),
		]

		view?.update(with: movies)
	}
}
*/
