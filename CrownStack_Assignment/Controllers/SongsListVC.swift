//
//  SongsListVC.swift
//  CrownStack_Assignment
//
//  Created by Mayank Sehgal on 26/07/21.
//

import UIKit

class SongsListVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var songsTBView: UITableView!
    @IBOutlet weak var errorLbl: UILabel!
    
    //MARK:- Properties
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    var viewModel: SongsListVM = SongsListVM()

    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        populateSongs()
    }
    
    //MARK:- Internal Methods
    private func configureRefreshControl(){
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(populateSongs), for: .valueChanged)
        songsTBView.refreshControl = refreshControl
    }
    
    @objc private func populateSongs(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.requestSongs { [weak self](success, error) in
                self?.refreshControl.endRefreshing()
                if success{
                    self?.songsTBView.reloadData()
                    self?.errorLbl.isHidden = true
                }else{
                    self?.songsTBView.reloadData()
                    self?.errorLbl.isHidden = false
                }
            }
        }
    }
}

extension SongsListVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSongsRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.status == .none{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShimmerTableViewCell.identifier, for: indexPath) as? ShimmerTableViewCell else {
                return UITableViewCell()
                
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTVC.identifier, for: indexPath) as? SongTVC else {return UITableViewCell()}
        cell.cellViewModel = viewModel.getCellVM(for: indexPath)
        return UITableViewCell()
    }
}

extension SongsListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mod = viewModel.getCellModel(for: indexPath), let detailVC = SongDetailVC.instance(model: mod), viewModel.status != .none else {return}
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.bounds.width - 16) * 0.54
    }
}
