/*
  Copyright (C) 2013-2014 The Communi Project

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the copyright holder nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0

Dialog {
    id: dialog

    property alias nick: nickField.text
    property alias index: networkBox.currentIndex
    readonly property var model: BufferModel.models[networkBox.currentIndex]

    canAccept: !!nick.trim() && nick !== initialNick
    allowedOrientations: window.allowedOrientations

    property string initialNick
    Component.onCompleted: initialNick = nick

    SilicaListView {
        anchors.fill: parent
        spacing: Theme.paddingMedium
        header: DialogHeader { title: qsTr("Nick") }
        model: VisualItemModel {
            ComboBox {
                id: networkBox
                width: parent.width
                label: qsTr("Network:")
                menu: ContextMenu {
                    Repeater {
                        model: BufferModel.connections
                        delegate: MenuItem {
                            visible: modelData.enabled
                            text: modelData.displayName
                        }
                    }
                }
            }

            TextField {
                id: nickField
                width: parent.width
                text: initialNick
                label: qsTr("Nick name")
                errorHighlight: !dialog.canAccept
                placeholderText: qsTr("Enter nick name")

                EnterKey.text: qsTr("Set")
                EnterKey.enabled: dialog.canAccept
                EnterKey.highlighted: true
                EnterKey.onClicked: dialog.accept()
            }
        }
        VerticalScrollDecorator { }
    }
}
