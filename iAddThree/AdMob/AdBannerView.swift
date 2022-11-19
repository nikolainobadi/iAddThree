//
//  AdBannerView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI
import GoogleMobileAds

struct AdBannerView: View {
    let adId: String
    
    var body: some View {
        AdBannerVC(adId: adId)
            .frame(maxWidth: getWidthPercent(80), maxHeight: getHeightPercent(6))
    }
}


// MARK: - ViewController
final private class AdBannerVC: UIViewControllerRepresentable {
    private let adId: String
    
    init(adId: String) {
        self.adId = adId
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        let view = GADBannerView(adSize: GADAdSizeBanner)
        
        vc.view.addSubview(view)
        
        view.adUnitID = adId
        view.rootViewController = vc
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: vc.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: vc.view.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        view.load(GADRequest())

        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}


// MARK: - Preview
struct AdBanner_Previews: PreviewProvider {
    static var previews: some View {
        AdBannerView(adId: AdMobId.banner.testId)
    }
}
