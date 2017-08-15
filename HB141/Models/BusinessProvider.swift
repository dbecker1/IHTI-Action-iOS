//
//  BusinessProvider.swift
//  HB141
//
//  Created by Daniel Becker on 6/25/17.
//  Copyright © 2017 International Human Trafficking Institute. All rights reserved.
//

import Foundation

class BusinessProvider {
    var businesses : [Business?]
    
    static let shared = BusinessProvider()
    
    private init() {
        self.businesses = [Business?](repeating: nil, count: GoogleConstants.businessCount)
    }
    
    func clearBusinesses() {
        self.businesses = [Business?](repeating: nil, count: GoogleConstants.businessCount)
    }
    
    func addBusiness(newBusiness: Business) {
        businesses.append(newBusiness)
        
        sendUpdateNotification(businessId: newBusiness.placeID!)
    }
    
    func updateImage(forId businessId: String, newImage: UIImage?) {
        if let newImage = newImage { // sometimes it might not find an image
            if let business = businesses.first(where: { $0?.placeID == businessId })! {
                business.image = newImage
                
                sendUpdateNotification(businessId: business.placeID!)
            }
        }
    }
    
    func getBusiness(forId businessId: String) -> Business? {
        if let business = businesses.first(where: { $0?.placeID == businessId })! {
            return business
        }
        return nil
    }
    
    func getBusinessIds() -> [String] {
        var ids = [String]()
        
        for business in businesses {
            if business != nil {
                ids.append((business?.placeID)!)
            }
        }
        
        return ids
    }
    
    func getBusinessCount() -> Int {
        return businesses.count
    }
    
    private func sendUpdateNotification(businessId: String) {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(rawValue:"BusinessUpdate"), object: nil, userInfo: ["businessId" : businessId])
    }
}
