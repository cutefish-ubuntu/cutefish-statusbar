/*
 * Copyright (C) 2021 CutefishOS Team.
 *
 * Author:     Reion Wong <aj@cutefishos.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import FishUI 1.0 as FishUI

Item {
    id: control

    property bool checked: false
    property alias icon: _image.source
    property alias label: _titleLabel.text
    property alias text: _label.text

    signal clicked

    property var backgroundColor: FishUI.Theme.darkMode ? Qt.rgba(255, 255, 255, 0.4)
                                                        : Qt.rgba(0, 0, 0, 0.1)
    property var hoverColor: FishUI.Theme.darkMode ? Qt.rgba(255, 255, 255, 0.5)
                                                   : Qt.rgba(0, 0, 0, 0.2)
    property var pressedColor: FishUI.Theme.darkMode ? Qt.rgba(255, 255, 255, 0.3)
                                                     : Qt.rgba(0, 0, 0, 0.15)

    property var highlightHoverColor: FishUI.Theme.darkMode ? Qt.lighter(FishUI.Theme.highlightColor, 1.1)
                                                            : Qt.darker(FishUI.Theme.highlightColor, 1.1)
    property var highlightPressedColor: FishUI.Theme.darkMode ? Qt.lighter(FishUI.Theme.highlightColor, 1.1)
                                                              : Qt.darker(FishUI.Theme.highlightColor, 1.2)

    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: control.clicked()

        onPressedChanged: {
            control.scale = pressed ? 0.95 : 1.0
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 100
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: FishUI.Theme.bigRadius
        opacity: control.checked ? 0.9 : FishUI.Theme.darkMode ? 0.3 : 0.5

        color: {
            if (control.checked) {
                if (_mouseArea.pressed)
                    return highlightPressedColor
                else if (_mouseArea.containsMouse)
                    return highlightHoverColor
                else
                    return FishUI.Theme.highlightColor
            } else {
                if (_mouseArea.pressed)
                    return pressedColor
                else if (_mouseArea.containsMouse)
                    return hoverColor
                else
                    return backgroundColor
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: FishUI.Theme.smallRadius
        anchors.rightMargin: FishUI.Theme.smallRadius

        Image {
            id: _image
            Layout.preferredWidth: control.height * 0.3
            Layout.preferredHeight: control.height * 0.3
            sourceSize: Qt.size(width, height)
            asynchronous: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: FishUI.Units.largeSpacing

//            ColorOverlay {
//                anchors.fill: _image
//                source: _image
//                color: control.checked ? FishUI.Theme.highlightedTextColor : FishUI.Theme.disabledTextColor
//            }
        }

        Item {
            Layout.fillHeight: true
        }

        Label {
            id: _titleLabel
            color: control.checked ? FishUI.Theme.highlightedTextColor : FishUI.Theme.textColor
            Layout.preferredHeight: control.height * 0.15
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }

        Label {
            id: _label
            color: control.checked ? FishUI.Theme.highlightedTextColor : FishUI.Theme.textColor
            elide: Label.ElideRight
            Layout.preferredHeight: control.height * 0.1
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: control.width - FishUI.Units.largeSpacing
            Layout.bottomMargin: FishUI.Units.largeSpacing
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
