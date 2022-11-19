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
            .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(6), alignment: .center)
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
        
        view.adUnitID = adId
        view.rootViewController = vc
        vc.view.addSubview(view)
        vc.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
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
