//
//  PreviousReportsController.swift
//  HB141
//
//  Created by Emma Flynn & Binit Shah on 4/10/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit

class PreviousReportsController : UITableViewController {

    @IBOutlet var previousReportsTableView: UITableView!
    var firebaseIndicator : UIActivityIndicatorView = UIActivityIndicatorView();
    var reports = [Report]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "Previous Reports";
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        navigationItem.leftBarButtonItem = BaseNavigationController.getMenuButton()
        navigationItem.backBarButtonItem = BaseNavigationController.getBackButton()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            navigationItem.leftBarButtonItem?.target = self.revealViewController()
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        firebaseIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray);
        firebaseIndicator.center = view.center;
        firebaseIndicator.startAnimating();
        view.addSubview(firebaseIndicator);
        
        getReports();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = previousReportsTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row;
            let previousReportDetailController = segue.destination as! PreviousReportDetailController;
            let report = reports[selectedRow];
            previousReportDetailController.location = report.establishment?.Name;
            previousReportDetailController.datetime = report.Datetime;
            previousReportDetailController.address = report.establishment?.Address;
            previousReportDetailController.comment = report.Comment;
            previousReportDetailController.noview = report.NoView;
            previousReportDetailController.publicview = report.PublicView;
            previousReportDetailController.restroomview = report.RestroomView;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousReport", for: indexPath) as! PreviousReportCell;
        let row = indexPath.row;
        let report = reports[row];
        cell.decorate(for: report, in: self);
        
        return cell;
    }
    
    func getReports() {
        if let uid = AuthManager.shared.current()?.uid {
            let reportService = FirebaseService(table: .report)
            let establishmentService = FirebaseService(table: .establishment)
            reportService.retrieveAll() {
                (result) -> Void in
                for child in result {
                    if let report = child as? Report {
                        if report.VID == uid {
                            establishmentService.retrieveData(forIdentifier: report.EID) {
                                (result) -> Void in
                                if let establishment = result as? Establishment {
                                    report.establishment = establishment
                                    self.reports.append(report)
                                    self.tableView.reloadData();
                                }
                            }
                        }
                    }
                }
                self.firebaseIndicator.stopAnimating();
            }
        }
    }
    
}

class PreviousReportCell: UITableViewCell {
    var location: String!;
    var controller: PreviousReportsController!;
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    func decorate(for report: Report, in controller: PreviousReportsController) {
        
        let datetime = report.Datetime;
        let location = report.establishment!.Name
        self.locationLabel.text = "\(location)";
        self.dateTimeLabel.text = "\(datetime)";
        
        self.location = location;
        self.controller = controller;
    }
}
