//
//  FeaturedPresenter.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 27/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol FeaturedView: class {
	func setShowsHeaderTitle(_ title: String)
	func setMoviesHeaderTitle(_ title: String)

	func update(with shows: [Show])
	func update(with movies: [Movie])
}

final class FeaturedPresenter {
	weak var view: FeaturedView?

	func didLoad() {
		view?.setShowsHeaderTitle(NSLocalizedString("ON TV", comment: ""))
		view?.setMoviesHeaderTitle(NSLocalizedString("IN THEATERS", comment: ""))

		addFakeContent()
	}

	func didSelect(show: Show) {
		// TODO: implement
	}

	func didSelect(movie: Movie) {
		// TODO: implement
	}
}

private extension FeaturedPresenter {
	func addFakeContent() {
		let shows = [
			Show(identifier: 1413,
			     title: "American Horror Story",
			     posterPath: "/gwSzP1cJL2HsBmGStN2vOg3d4Qd.jpg",
			     backdropPath: "/anDMMvgVV6pTNSxhHgiDPUjc4pH.jpg",
			     firstAirDate: Date(timeIntervalSince1970: 1274905532),
			     genreIdentifiers: [18, 9648])
		]

		view?.update(with: shows)

		let movies = [
			Movie(identifier: 330459,
			      title: "Rogue One: A Star Wars Story",
			      posterPath: "/qjiskwlV1qQzRCjpV0cL9pEMF9a.jpg",
			      backdropPath: "/tZjVVIYXACV4IIIhXeIM59ytqwS.jpg",
			      releaseDate: Date(timeIntervalSince1970: 1474905532),
			      genreIdentifiers: [28, 12, 878]),
			Movie(identifier: 297762,
			      title: "Wonder Woman",
			      posterPath: "/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg",
			      backdropPath: "/hA5oCgvgCxj5MEWcLpjXXTwEANF.jpg",
			      releaseDate: Date(timeIntervalSince1970: 1574905532),
			      genreIdentifiers: [28, 12, 14, 878]),
			Movie(identifier: 324852,
			      title: "Despicable Me 3",
			      posterPath: "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg",
			      backdropPath: "/7YoKt3hzTg38iPlpCumqcriaNTV.jpg",
			      releaseDate: Date(timeIntervalSince1970: 1564905532),
			      genreIdentifiers: [12, 16, 35]),
		]

		view?.update(with: movies)
	}
}
