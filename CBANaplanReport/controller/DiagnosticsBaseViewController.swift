//
//  DiagnosticsBaseViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 3/6/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit
import Charts

class DiagnosticsBaseViewController: UIViewController {
    weak var activityIndicaView: UIActivityIndicatorView?
    let NoDataText = "No Naplan result found"
    @IBOutlet var barChartView: BarChartView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView = NaplanUIView.createActivityIndicator(inView: self.barChartView)
        activityIndicatorView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        prepareForChar()
        makeLegend()
        initData()
        setChart()
        showChart()
        activityIndicatorView.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        addRightButtonItems(inController: self, withOptions: [NaplanOptions.saveChart, NaplanOptions.logout])
    }

    // this method must be override by subclass
    func initData(){
    }
    // this method must be override by subclass
    func setChart(){
    }
    func saveChart() {
         activityIndicaView = NaplanUIView.createActivityIndicator(inView: self.view)
        if let activity = activityIndicaView {
            activity.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        if let imageChart:UIImage = barChartView.getChartImage(transparent: false) {
            UIImageWriteToSavedPhotosAlbum(imageChart, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            NaplanUIView.showAlert(withMessage: "Cannot save this chart", inViewController: self)
        }
    }
 
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            NaplanUIView.showAlert(withMessage: "Cannot save this chart because of \(error.domain)", inViewController: self)
        } else {
             NaplanUIView.showAlert(withMessage: "Your diagnostics has been saved to your photos.", inViewController: self)
        }
        if let activity = activityIndicaView {
            activity.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
   
    func makeLegend(){
        // MARK: legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.orientation = .horizontal
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.enabled = true
    }
    func prepareForChar(){
        barChartView.noDataText = NoDataText
        barChartView.chartDescription?.text = ""
        barChartView.drawGridBackgroundEnabled = true
        barChartView.maxVisibleCount = 20
        // MARK: xAxis
        let xaxis = barChartView.xAxis
        xaxis.labelFont = UIFont.boldSystemFont(ofSize: 15)
        xaxis.granularity = 1.0
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottomInside
        // MARK: yAxis
        let leftAxis = barChartView.leftAxis
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0.0
        leftAxis.drawGridLinesEnabled = true
        leftAxis.labelPosition = .outsideChart
        let rightAxis = barChartView.rightAxis
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0.0
        rightAxis.drawGridLinesEnabled = true
        rightAxis.labelPosition = .outsideChart
        rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.enabled = true
    }
    func showChart(){
        barChartView.data?.notifyDataChanged()
        barChartView.notifyDataSetChanged()
        barChartView.backgroundColor = UIColor.white
        barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .linear)
    }
}

