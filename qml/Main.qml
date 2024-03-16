/*
 * Copyright (C) 2024  walking-octopus
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * calc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "libs/nerdamer/qt-all.js" as Nerdamer
import "libs/mathjax.js" as Mathjax

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'calc.walking-octopus'
    automaticOrientation: true
    anchorToKeyboard: true

    width: units.gu(50)
    height: units.gu(70)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Calc')
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: units.gu(1)

            TextField {
                id: userInput
                text: "x^2+2*x+1"
                font.pixelSize: FontUtils.sizeToPixels("large")

                inputMethodHints: Qt.ImhNoPredictiveText
                focus: true

                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: units.gu(25)

                Image {
                    anchors.centerIn: parent
                    sourceSize.width: parent.width

                    width: parent.width * 0.8
                    height: parent.height * 0.15
                    smooth: true
                    antialiasing: true

                    cache: true
                    fillMode: Image.PreserveAspectFit

                    source: {
                        try {
                            const solution = Nerdamer.nerdamer(userInput.text);
                            return "https://latex.codecogs.com/svg.image?" + encodeURIComponent(Nerdamer.nerdamer.convertToLaTeX(solution.text()));
                        } catch (error) {
                            return `data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='50'><text x='10' y='30' fill='red' font-size='24'>ERROR</text></svg>`
                        }
                    }
                }
            }
        }
    }
}
