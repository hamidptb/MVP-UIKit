//
//  ArticleListPresenter.swift
//  MVP UIKit
//
//  Created by Hamid on 12/15/24.
//

import Foundation

protocol ArticleListViewProtocol: AnyObject {
    func showArticles(_ articles: [Article])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

class ArticleListPresenter {
    private let apiService: APIService
    weak var view: ArticleListViewProtocol?
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func attachView(_ view: ArticleListViewProtocol) {
        self.view = view
    }
    
    func fetchArticles() {
        view?.showLoading()
        
        apiService.fetchArticles { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success(let articles):
                    self?.view?.showArticles(articles)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}
