//
//  HomeViewController.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import UIKit
import SnapKit

protocol IHomeViewController {
    var tableViewDatas: [CharacterData.Result] { get set }
    var isLoading: Bool { get set }
    var isFinish: Bool { get set }
    var currentPage: Int { get set }
    var currentFilter: String { get set }
}

class HomeViewController: UIViewController, IHomeViewController {
    
    //View Definations
    private let pageTitle: UILabel = UILabel()
    private let filterButton: UIButton = UIButton(type: .custom)
    private let tableView: UITableView = UITableView()
    
    //AlertView Definations
    private let alertContent: UILabel = UILabel()
    
    //Veriables
    var tableViewDatas: [CharacterData.Result] = []
    var isLoading: Bool = true
    var isFinish: Bool = false
    var currentPage: Int = 1
    var currentFilter: String = ""
    
    private var homeViewModel:IHomeViewModel = HomeViewModel()
    private let alertController = FilterAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
        runOnStart()
    }
    
    override func viewDidLayoutSubviews() {
        viewConfigurations()
    }
    
    func viewConfigurations() {
        view.addSubview(pageTitle)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        
        drawPageTile()
        drawFilterButton()
        drawTableView()
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.pageTitle.font = .boldSystemFont(ofSize: 24)
            self.pageTitle.text = "Rick and Morty"
            
            if let filterButton = UIImage(named: ImageEnum.filterImage.rawValue) {
                self.filterButton.setImage(filterButton, for: .normal)
            }
            
            self.tableView.allowsSelection = false
            self.tableView.separatorColor = .clear
            self.tableView.rowHeight = 281 //265
        }
        
        //Filter set click action
        self.filterButton.addTarget(self, action: #selector(showFilterAlertView), for: .touchUpInside)
    }

    func runOnStart() {
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.homeViewDelegate = self
        alertController.filterAlertDelegate = self
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.Identifier.custom.rawValue)
        
        homeViewModel.fetch(page: 1, characterName: currentFilter)
    }
}

//MARK: - Snapkit View features
extension HomeViewController {
    func drawPageTile() {
        pageTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(28)
        }
    }
    
    func drawFilterButton() {
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-24)
        }
    }
    
    func drawTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom).offset(22)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - Tableview Delegate & Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.Identifier.custom.rawValue) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: tableViewDatas[indexPath.row])
        return cell
    }
    
    //infinite scroll function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if !isFinish && !isLoading {
                isLoading = true
                currentPage += 1
                homeViewModel.fetch(page: currentPage, characterName: currentFilter)
            }
        }
    }
    
}

//MARK: - HomeViewDelegate
extension HomeViewController: IHomeViewModelDelegate {
    //Called by delegate, if it's last page
    func isFinish(finished: Bool) {
        isFinish = true
    }
    
    //return rick and morty dattas from network
    func setRickAndMortyDatas(data: CharacterData) {
        if let rickMortyData = data.results {
            tableViewDatas += rickMortyData  as! [CharacterData.Result]
            tableView.reloadData()
            isLoading = false
        }
    }
}

//MARK: - FilterAlert Defination
extension HomeViewController {
    @objc func showFilterAlertView(){
        alertController.providesPresentationContextTransitionStyle = true
        alertController.definesPresentationContext = true
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.modalTransitionStyle = .crossDissolve
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: -IFilterAlertDelegate DEfination
extension HomeViewController: IFilterAlertDelegate {
    func filterChanged(changedFilter: String) {
        tableViewDatas = []
        tableView.reloadData()
        setDefaultFilterParameters()
        currentFilter = changedFilter
        homeViewModel.fetch(page: currentPage, characterName: currentFilter)
        tableView.setContentOffset(.zero, animated: true)
        alertController.dismiss(animated: true, completion: nil)
    }
    
    func setDefaultFilterParameters(){
        currentPage = 1
        isFinish = false
        isLoading = false
    }
}
