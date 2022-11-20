//
//  DispatchQueue+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import Combine
import Foundation

extension DispatchQueue {
    static var customScheduler: ImmediateWhenOnMain { ImmediateWhenOnMain( ) }
    
    struct ImmediateWhenOnMain: Scheduler {
        typealias SchedulerOptions = DispatchQueue.SchedulerOptions
        typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
        
        var now: DispatchQueue.SchedulerTimeType { DispatchQueue.main.now }
        var minimumTolerance: DispatchQueue.SchedulerTimeType.Stride { DispatchQueue.main.minimumTolerance }
        
        func schedule(options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            guard Thread.isMainThread else {
                return DispatchQueue.main.schedule(options: options, action)
            }
            
            action()
        }
        
        func schedule(after date: DispatchQueue.SchedulerTimeType, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            
            DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
        }
        
        func schedule(after date: DispatchQueue.SchedulerTimeType, interval: DispatchQueue.SchedulerTimeType.Stride, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
            
            DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, action)
        }
    }
}
