//
//  ViewController.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import Foundation
import UIKit

class TelstraViewController: UIViewController {
    
    var viewModel: TableViewModel!
    var dataSet : [ModelRowData] = []
    let cellId = "tableCellId"
    var imageDownloader : ImgDownloader?
    var tableView = UITableView()
    var spinner: UIView?
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TableViewModel.init(responder: self)
        imageDownloader = ImgDownloader()
        setTableView()
        self.showSpinner(onView: self.view)
        viewModel.loadTelstraData()
        initRefreshControl();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeSpinner()
        self.refreshControl.endRefreshing();
    }
    
    func initRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        addConstraintsForTableView()
    }
    
    func addConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        viewModel.loadTelstraData()
    }
}

//MARK: Extension for TableView functionailty
extension TelstraViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Tableview data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
        let currentItem = dataSet[indexPath.row]
        cell.tvTitle.text = currentItem.title
        cell.tvDesc.text = currentItem.description
        return cell
    }
    
    // MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TableViewCell
        let currentItem = dataSet[indexPath.row]
        cell.ivThumbImg.image = UIImage(named: "default.png")
        if let imageUrl = currentItem.imageHref {
            DispatchQueue.global(qos: .default).async {
                self.imageDownloader?.getImageForPath(path: imageUrl, completion: { (image) in
                    DispatchQueue.main.async {
                        if tableView.cellForRow(at: indexPath) != nil {
                            if(image != nil){
                                cell.ivThumbImg.image = image
                            }
                        }
                    }
                })
            }
        }
    }
}

extension TelstraViewController: Responder {
     // MARK: Responder callback
    func updateRowData(_ data: [ModelRowData]) {
        self.dataSet = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeSpinner()
            self.refreshControl.endRefreshing();
        }
    }
    
    func updateTitle(_ title: String) {
        DispatchQueue.main.async {
            self.title = title
        }
    }
}

extension TelstraViewController {
    // MARK: showing spinner
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        spinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
}
