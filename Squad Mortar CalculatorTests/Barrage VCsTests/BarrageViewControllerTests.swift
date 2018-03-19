//
//  BarrageViewControllerTests.swift
//  Squad Mortar CalculatorTests
//
//  Created by James Longman on 19/03/2018.
//  Copyright © 2018 James Longman. All rights reserved.
//

import XCTest
@testable import Squad_Mortar_Calculator

class BarrageViewControllerTests: XCTestCase {
    var vc: BarrageViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "BarrageView") as? BarrageViewController
        let _ = vc.view
    }
    
    func testTimerRadius() {
        // If width of frame is larger, should base radius off of height
        vc.leftTimingView.frame.size.width = 200

        /* Easiest test is through linewidth as it should be the lesser of:
         ((height or width / 2) - 20) / 10 */
        vc.leftTimingView.frame.size.height = 100
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.shapeLayer.lineWidth, 3)

        vc.leftTimingView.frame.size.height = 80
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.trackLayer.lineWidth, 2)

        vc.leftTimingView.frame.size.height = 50
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.shapeLayer.lineWidth, 0.5)

        // Now test when height is greater
        vc.leftTimingView.frame.size.height = 1000

        vc.leftTimingView.frame.size.width = 500
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.shapeLayer.lineWidth, 23)

        vc.leftTimingView.frame.size.width = 350
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.trackLayer.lineWidth, 15.5)

        vc.leftTimingView.frame.size.width = 172.673
        vc.viewWillLayoutSubviews()
        XCTAssertEqual(vc.shapeLayer.lineWidth, 6.63365)
    }

    func testTrackLayerAndShapeLayer() {
        vc.leftTimingView.frame.size.height = 100
        vc.leftTimingView.frame.size.width = 100
        vc.leftTimingView.center = CGPoint(x: 300, y: 300)
        vc.viewWillLayoutSubviews()

        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 300, y: 300), radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)

        XCTAssertEqual(vc.trackLayer.path, circularPath.cgPath)
        XCTAssertEqual(vc.trackLayer.strokeColor, UIColor.gray.cgColor)
        XCTAssertEqual(vc.trackLayer.lineWidth, 3)
        XCTAssertEqual(vc.trackLayer.fillColor, UIColor.clear.cgColor)

        XCTAssertEqual(vc.shapeLayer.path, circularPath.cgPath)
        XCTAssertEqual(vc.shapeLayer.strokeColor, UIColor.orange.cgColor)
        XCTAssertEqual(vc.shapeLayer.lineWidth, 3)
        XCTAssertEqual(vc.shapeLayer.strokeEnd, 0)
        XCTAssertEqual(vc.shapeLayer.fillColor, UIColor.clear.cgColor)
    }

    func testTackAndShapeSublayersAdded() {
        var initialSublayers = 0
        for _ in vc.leftTimingView.layer.sublayers! {
            initialSublayers += 1
        }

        vc.viewWillLayoutSubviews()

        var sublayerCounter = 0
        for _ in vc.leftTimingView.layer.sublayers! {
            sublayerCounter += 1
        }

        // Should have added the trackLayer and shapeLayer
        XCTAssertEqual(sublayerCounter - initialSublayers, 2)
    }

    func testTimerLabelPlacement() {
        vc.leftTimingView.center = CGPoint(x: 1000, y: 1000)
        vc.viewWillLayoutSubviews()

        XCTAssertEqual(vc.timerLabel.center, CGPoint(x: 1000, y: 1000))

        vc.leftTimingView.center = CGPoint(x: 400, y: 400)
        vc.viewWillLayoutSubviews()

        XCTAssertEqual(vc.timerLabel.center, CGPoint(x: 400, y: 400))

        vc.leftTimingView.center = CGPoint(x: 341, y: 421)
        vc.viewWillLayoutSubviews()

        XCTAssertEqual(vc.timerLabel.center, CGPoint(x: 341, y: 421))
    }

}
