//
//  PreviousReportsController.swift
//  HB141
//
//  Created by Emma Flynn & Binit Shah on 4/10/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import UIKit
import Firebase

class PreviousReportsController : UITableViewController {
    
    var dummyReports = ["Smith Hall": "Monday the Third of July", "Welcome to the Jungle": "I am pretty awesome.", "Emma Flynn is a fool": "Yes she is.", "North ave dining is fabulous": "said no one ever."];
    @IBOutlet var previousReportsTableView: UITableView!
    var databaseRef: FIRDatabaseReference!;
    var firebaseIndicator : UIActivityIndicatorView = UIActivityIndicatorView();
    var reports = [Report]()
    var firebaseWasPinged: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false;
        self.title = "Previous Reports";
        
        firebaseIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray);
        firebaseIndicator.center = view.center;
        firebaseIndicator.startAnimating();
        view.addSubview(firebaseIndicator);
        
        databaseRef = FIRDatabase.database().reference();
        
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
            previousReportDetailController.location = report.EID;
            previousReportDetailController.datetime = report.Datetime;
            previousReportDetailController.address = report.EID;
            previousReportDetailController.comment = report.Comment;
            previousReportDetailController.noview = report.NoView;
            previousReportDetailController.publicview = report.PublicView;
            previousReportDetailController.restroomview = report.RestroomView;
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(reports.count);
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
        if (!firebaseWasPinged) {
            print("START");
            let reportsRef = self.databaseRef.child("report");
            _ = reportsRef.observe(FIRDataEventType.value, with: { (snapshot) in
                for child in snapshot.children {
                    let actualChild : FIRDataSnapshot = (child as? FIRDataSnapshot)!;
                    var reportComment : String = "";
                    var reportDateTime : String = "";
                    var reportEID : String = "";
                    var reportNoView : Bool = false;
                    var reportPublicView : Bool = false;
                    var reportRestroomView : Bool = false;
                    var reportVID : String = "";
                    for property in actualChild.children {
                        let actualProperty : FIRDataSnapshot = (property as? FIRDataSnapshot)!;
                        switch (actualProperty.key) {
                            case "Comment":
                                reportComment = actualProperty.value as! String;
                                break;
                            case "Datetime":
                                reportDateTime = actualProperty.value as! String;
                                break;
                            case "EID":
                                reportEID = actualProperty.value as! String;
                                break;
                            case "No View":
                                reportNoView = actualProperty.value as! Bool;
                                break;
                            case "Public View":
                                reportPublicView = actualProperty.value as! Bool;
                                break;
                            case "Restroom View":
                                reportRestroomView = actualProperty.value as! Bool;
                                break;
                            case "VID":
                                reportVID = actualProperty.value as! String;
                                break;
                            default:
                                print("key: \(actualProperty.key) and value: \(String(describing: actualProperty.value))");
                                break;
                        }
                    }
                    if (reportVID == FIRAuth.auth()?.currentUser?.uid) {
                        let tempReport : Report = Report();
                        tempReport.Comment = reportComment;
                        tempReport.Datetime = reportDateTime;
                        tempReport.EID = reportEID;
                        if (reportNoView) {
                            tempReport.NoView = "No View";
                        }
                        if (reportPublicView) {
                            tempReport.PublicView = "Public View";
                        }
                        if (reportRestroomView) {
                            tempReport.RestroomView = "Restroom View";
                        }
                        tempReport.VID = reportVID;
                        
                        self.reports.append(tempReport);
                    }
                }
                self.firebaseIndicator.stopAnimating();
                self.tableView.reloadData();
            });
            firebaseWasPinged = true;
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
        let location = report.EID;
        self.locationLabel.text = "\(location)";
        self.dateTimeLabel.text = "\(datetime)";
        
        self.location = location;
        self.controller = controller;
    }
}
