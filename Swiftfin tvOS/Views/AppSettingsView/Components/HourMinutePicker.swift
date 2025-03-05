//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import SwiftUI
import TVOSPicker

struct HourMinutePicker: UIViewRepresentable {

    let interval: Binding<TimeInterval>

    func makeUIView(context: Context) -> some UIView {
        let picker = TVOSPickerView(
            style: .default // pass custom style here if needed
        )

//        let picker = UIDatePicker(frame: .zero)
//        picker.datePickerMode = .countDownTimer
//        picker.countDownDuration = interval.wrappedValue
        picker.translatesAutoresizingMaskIntoConstraints = false

        context.coordinator.add(picker: picker)
        context.coordinator.interval = interval

        return picker
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: TVOSPickerViewDelegate {
        var interval: Binding<TimeInterval>!

        func add(picker: TVOSPickerView) {
            picker.delegate = self
        }

        func numberOfComponents(in pickerView: TVOSPickerView) -> Int {
            // number of components (columns)
            2
        }

        func pickerView(_ pickerView: TVOSPickerView, numberOfRowsInComponent component: Int) -> Int {
            // number of rows in each component
            if component == 0 {
                23
            } else {
                60
            }
        }

        func pickerView(_ pickerView: TVOSPickerView, titleForRow row: Int, inComponent component: Int) -> String? {
            // string to display in each row
            if row == 0 {
                "hours"
            } else {
                "min"
            }
        }

        func pickerView(_ pickerView: TVOSPickerView, didSelectRow row: Int, inComponent component: Int) {
            // update state with the newly selected row

            var interval: TimeInterval = 0
            if component == 0 {
                interval += Double(row * 3600)
            } else {
                interval += Double(row * 60)
            }

            self.interval.wrappedValue = interval
        }

        func indexOfSelectedRow(inComponent component: Int, ofPickerView pickerView: TVOSPickerView) -> Int? {
            // provide an index of selected row - used as initially focused index as well as after each reloadData
            nil
        }
    }
}
