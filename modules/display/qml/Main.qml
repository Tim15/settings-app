/*
 * System Settings - Settings app for Papyros
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Papyros.Desktop 0.1

Item {
    Column {
        id: column

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            margins: Units.dp(16)
        }

        width: Math.min(Units.dp(400), parent.width - anchors.margins * 2)

        ListItem.Subtitled {
            text: "Display scale"
            valueText: scaleSlider.valueInfo(scaleSlider.value)
            interactive: false

            content: Slider {
                id: scaleSlider

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: Units.dp(7)

                minimumValue: 0.1
                maximumValue: 5
                numericValueLabel: true
                stepSize: 0.1

                function valueInfo(v) {
                    return (v * 100).toFixed(0) + "%"
                }

                value: ShellSettings.display.multiplier
            }
        }
    }


    Button {
        anchors {
            margins: Units.dp(16)
            bottom: parent.bottom
            right: parent.right
        }

        elevation: 1
        backgroundColor: Palette.colors["blue"]["500"]
        text: "Apply"
        enabled: ShellSettings.display.multiplier != scaleSlider.value
        onClicked: {
            ShellSettings.display.multiplier = scaleSlider.value
            scaleSlider.value = Qt.binding(function() {
                return ShellSettings.display.multiplier
            })
        }
    }
}
