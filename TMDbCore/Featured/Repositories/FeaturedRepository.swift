//
//  FeaturedRepository.swift
//  TMDbCore
//
//  Created by Carlos on 16/10/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import RxSwift

protocol FeaturedRepositoryProtocol {
    func moviesNowPlaying(region: String) -> Observable<[Movie]>
    func showsOnTheAir() -> Observable<[Show]>
}

final class FeaturedRepository: FeaturedRepositoryProtocol {
    // Dependencias
    private let webService: WebService
    
    //Inyectar las dependencias
    init(webService: WebService) {
        self.webService = webService
    }
    
    func moviesNowPlaying(region: String) -> Observable<[Movie]> {
        return webService.load(Page<Movie>.self, from: .moviesNowPlaying(region: region, page: 1))
            .map { $0.results }
    }
    
    func showsOnTheAir() -> Observable<[Show]> {
        return webService.load(Page<Show>.self, from: .showsOnTheAir(page: 1))
            .map { $0.results }
    }
    
}
