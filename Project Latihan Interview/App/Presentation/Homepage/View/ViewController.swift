//
//  ViewController.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import UIKit
import RxSwift

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PostViewModel?
    private let disposeBag = DisposeBag()
    
    private var dataToRender: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.bind()
    }

    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.ID)
    }
    
    private func bind() {
        self.viewModel?.error
            .subscribe(onNext: { errorMessage in
                
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
        
        self.viewModel?.posts
            .subscribe(onNext: { post in
                self.dataToRender = post
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }, onError: { error in
                // TODO: - add error message
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToRender.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.ID, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        let currentData = dataToRender[indexPath.row]
        cell.setupData(title: currentData.title,
                       body: currentData.body)
        return cell
    }
}

