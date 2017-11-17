import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtCharts 2.0

ApplicationWindow {
    visible: true
    width:700
    height: 400
    Rectangle
    {
        id: window_background
        anchors.fill: parent
        color: "#455a64"//"#55aaff"
    }
    property int ethPacketCount:0;
    property int ipv4PacketCount:0;
    property int ipv6PacketCount:0;
    property int tcpPacketCount:0;
    property int udpPacketCount:0;
    property int dnsPacketCount:0;
    property int httpPacketCount:0;
    property int sslPacketCount:0;

    property int sipPacketCount:0 ;

    property int  voipPacketCount:0;
    property int rtpPacketCount:0;
    property int ftpPacketCount:0;
    property int dhcpPacketCount:0;
    property int icmpPacketCount:0;
    property int pppoePacketCount:0;
    property int arpPacketCount:0;
    property int httpsPacketCount:0;

    property int totalPackets:0 ;
    property int sumOfAllSupported: 0

    property string ethLastPacketRecievedTime:"";
    property string ipv4LastPacketRecievedTime:"";
    property string ipv6LastPacketRecievedTime:"";
    property string tcpLastPacketRecievedTime:"";
    property string udpLastPacketRecievedTime:"";
    property string dnsLastPacketRecievedTime:"";
    property string httpLastPacketRecievedTime:"";
    property string sslLastPacketRecievedTime:"";

    property string sipLastPacketRecievedTime:"" ;

    property string  voipLastPacketRecievedTime:"";
    property string rtpLastPacketRecievedTime:"";
    property string ftpLastPacketRecievedTime:"";
    property string dhcpLastPacketRecievedTime:"";
    property string icmpLastPacketRecievedTime:"";
    property string pppoeLastPacketRecievedTime:"";
    property string arpLastPacketRecievedTime:"";
    property string httpsLastPacketRecievedTime:"";

    property string currentlyExplodedLabel: ""
    property int currentlyExplodedGraphNumber: 1

    property var lastPacket: []
    function updatePacketCounts()
    {
        ethPacketCount= operationsHandler.getEthPacketCount()
        ipv4PacketCount= operationsHandler.getIpv4PacketCount()
        ipv6PacketCount= operationsHandler.getIpv6PacketCount()
        tcpPacketCount= operationsHandler.getTcpPacketCount()
        udpPacketCount= operationsHandler.getUdpPacketCount()
        dnsPacketCount= operationsHandler.getDnsPacketCount()
        httpPacketCount= operationsHandler.getHttpPacketCount()
        sslPacketCount= operationsHandler.getSslPacketCount()
        sipPacketCount= operationsHandler.getSipPacketCount()
        voipPacketCount= operationsHandler.getVoipPacketCount()
        rtpPacketCount= operationsHandler.getRtpPacketCount()
        ftpPacketCount= operationsHandler.getFtpPacketCount()
        dhcpPacketCount= operationsHandler.getDhcpPacketCount()
        icmpPacketCount= operationsHandler.getIcmpPacketCount()
        pppoePacketCount= operationsHandler.getPppoePacketCount()
        arpPacketCount= operationsHandler.getArpPacketCount()
        httpsPacketCount= operationsHandler.getHttpsPacketCount()
        totalPackets= operationsHandler.getTotalPackets()
        sumOfAllSupported = ethPacketCount+ipv4PacketCount+ipv6PacketCount+tcpPacketCount+udpPacketCount
        +dnsPacketCount+httpPacketCount+sslPacketCount+sipPacketCount+voipPacketCount+rtpPacketCount+
                ftpPacketCount+dhcpPacketCount+ icmpPacketCount+ pppoePacketCount+ arpPacketCount
        +httpsPacketCount

        lastPacket["Ethernet"]= operationsHandler.getEthLastPacketRecievedTime()
        lastPacket["IPv4"]= operationsHandler.getIpv4LastPacketRecievedTime()
        lastPacket["IPv6"]= operationsHandler.getIpv6LastPacketRecievedTime()
        lastPacket["TCP"]= operationsHandler.getTcpLastPacketRecievedTime()
        lastPacket["UDP"]= operationsHandler.getUdpLastPacketRecievedTime()
        lastPacket["DNS"]= operationsHandler.getDnsLastPacketRecievedTime()
        lastPacket["VOIP"]= operationsHandler.getVoipLastPacketRecievedTime()
        lastPacket["RTP"]= operationsHandler.getRtpLastPacketRecievedTime()
        lastPacket["FTP"]= operationsHandler.getFtpLastPacketRecievedTime()
        lastPacket["DHCP"]= operationsHandler.getDhcpLastPacketRecievedTime()
        lastPacket["ICMP"]= operationsHandler.getIcmpLastPacketRecievedTime()
        lastPacket["PPPOE"]= operationsHandler.getPppoeLastPacketRecievedTime()
        lastPacket["ARP"]= operationsHandler.getArpLastPacketRecievedTime()
        lastPacket["HTTPS"]= operationsHandler.getHttpsLastPacketRecievedTime()
    }
    Timer
    {
        id: timer
        interval: 1000
        triggeredOnStart: false
        running: false
        repeat: true
        onTriggered: updatePacketCounts()
    }
    Rectangle
    {
        id: slider
        x:0
        z: 2
        anchors.verticalCenter: window_background.verticalCenter
        anchors.leftMargin: 2
        width: 10
        height: width*3
        Behavior on x
        {
            SmoothedAnimation{
                velocity: 150
                easing.type: Easing.InBounce
            }
        }
        Rectangle
        {
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.2
        }
        Image
        {
            id: slider_image
            anchors.fill: parent
            anchors.margins: 1
            //rotation: 90
            source: "qrc:/menu-orange.png"
            fillMode: Image.Stretch
            visible: true
            opacity: 1
        }
        color: "transparent"
        MouseArea
        {
            id: slider_mouse_area
            anchors.fill: parent
            hoverEnabled: true
            drag.axis: Drag.XAxis
            drag.minimumX: x
            drag.maximumX: window_background.width/2
            drag.target: slider
            onEntered: {cursorShape=Qt.OpenHandCursor}
            onExited: {
                if(!drag.active)
                {
                    cursorShape=Qt.ArrowCursor
                }
            }
            onReleased: {
                if(containsMouse)
                {
                    cursorShape=Qt.OpenHandCursor
                }
                else
                {
                    cursorShape=Qt.ArrowCursor
                    if(slider.x>0 && slider.x<(window_background.width/2)/2)
                    {
                        slider.x=0
                    }
                    else if(slider.x>0 && slider.x>=(window_background.width/2)/2)
                    {
                        slider.x=window_background.width/2
                    }
                }
            }
            onMouseXChanged: {
                if(drag.active)
                {
                    cursorShape=Qt.ClosedHandCursor
                }
                else cursorShape=Qt.OpenHandCursor
            }
            onClicked: {
                if(slider.x==0)
                {
                    slider.x=slide_menu.width
                }
                else
                {
                    slider.x=0
                }
            }
        }

    }
    Rectangle
    {
        id: slide_menu
        y: 0
        x: -width
        anchors.right: slider.left
        height: window_background.height
        anchors.verticalCenter: window_background.verticalCenter
        width: window_background.width/3
        color : "#ffffff"
        z: 11
    }
    Rectangle
    {
        id: info_box
        //anchors.top: parent.top
        //anchors.topMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: parent.width/2.5
        //anchors.bottom: resume_pause_button.top
        //anchors.bottomMargin: 30
        anchors.verticalCenter: progress_graph_rec.verticalCenter
        height: (15*7)+(15*4)
        //border.color: "#ffffff"
        //border.width: 3
        //radius: info_heading.radius
        color: "transparent"
        MouseArea
        {
            id: infobox_mouse_area
            anchors.fill: parent
            cursorShape: (slider_mouse_area.drag.active)? Qt.ClosedHandCursor: Qt.ArrowCursor
        }
        Rectangle
        {
            id: url_info
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            width: parent.width/1.1
            height: url_text.height
            color: "transparent"
            Label
            {
                id: url_text
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                //width: parent.width-url_label.width-10
                font.pointSize: 15
                height: 15
                font.family: "Comic Sans MS"
                text: totalPackets
                color: "#388e3c"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
            Label
            {
                id : url_label
                //width: 120
                anchors.left: parent.left
                anchors.right: url_text.left
                anchors.verticalCenter: url_text.verticalCenter
                height: parent.height
                font.pointSize: 10
                anchors.rightMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: "Total Packets Recieved "
                maximumLineCount: 2
                wrapMode: Label.Wrap
                color: "#ffffff"
                font.family: "Comic Sans MS"
            }
        }
        Rectangle
        {
            id: status_info
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: url_info.bottom
            anchors.topMargin: visible ? 20: 0
            width: parent.width/1.1
            height: currentlyExplodedGraphNumber==1 ?
                        (pieSeries.currentlyExplodedLabel=="" ? 0:url_text.height):
                        (pieSeries1.currentlyExplodedLabel=="" ? 0:url_text.height)
            visible: height!=0
            color: "transparent"
            Label
            {
                id: status_text
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                font.pointSize: 15
                font.family: "Comic Sans MS"
                height: parent.height
                text: currentlyExplodedLabel=="" ? 0: (currentlyExplodedGraphNumber==1 ?
                                                           pieSeries.find(currentlyExplodedLabel).value:
                                                           pieSeries1.find(currentlyExplodedLabel).value)
                color: "#388e3c"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
            Label
            {
                id : status_label
                anchors.right: status_text.left
                anchors.left: parent.left
                anchors.verticalCenter: status_text.verticalCenter
                height: parent.height
                font.pointSize: 10
                anchors.rightMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                maximumLineCount: 2
                wrapMode: Label.Wrap
                text: "Total from "+(currentlyExplodedLabel=="" ? "All" : currentlyExplodedLabel)
                color: "#ffffff"
                font.family: "Comic Sans MS"
            }
        }
        Rectangle
        {
            id: size_info
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: status_info.bottom
            anchors.topMargin: 20
            width: parent.width/1.1
            height: url_text.height
            color: "transparent"
            Label
            {
                id: size_text
                anchors.right: parent.right
                //width: parent.width-size_label.width-10
                anchors.left: parent.horizontalCenter
                font.pointSize: 15
                font.family: "Comic Sans MS"
                height: parent.height
                text:  currentlyExplodedLabel=="" ? "--":lastPacket[currentlyExplodedLabel]
                color: "#388e3c"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
            Label
            {
                id : size_label
                //width: 120
                anchors.left: parent.left
                anchors.right: size_text.left
                anchors.verticalCenter: size_text.verticalCenter
                height: parent.height
                font.pointSize: 10
                anchors.rightMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                maximumLineCount: 2
                wrapMode: Label.Wrap
                text: "Last packet recieved at "
                color: "#ffffff"
                font.family: "Comic Sans MS"
            }
        }
        Rectangle
        {
            id: downloaded_size_info
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: size_info.bottom
            anchors.topMargin: 20
            width: parent.width/1.1
            height: url_text.height
            color: "transparent"
            Label
            {
                id: downloaded_size_info_text
                anchors.right: parent.right
                //width: parent.width-downloaded_size_info_label.width-10
                anchors.left: parent.horizontalCenter
                font.pointSize: 15
                font.family: "Comic Sans MS"
                height: parent.height
                text: "--"
                color: "#388e3c"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
            Label
            {
                id : downloaded_size_info_label
                //width: 120
                anchors.right: downloaded_size_info_text.left
                anchors.left: parent.left
                anchors.verticalCenter: downloaded_size_info_text.verticalCenter
                height: parent.height
                font.pointSize: 10
                anchors.rightMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                maximumLineCount: 2
                wrapMode: Label.Wrap
                text: "Average frame size "
                color: "#ffffff"
                font.family: "Comic Sans MS"
            }
        }
    }
    Rectangle
    {
        visible: false
        id: info_heading
        color: "#ffffff"
        anchors.bottom: info_box.top
        anchors.left: info_box.left
        anchors.leftMargin: 5
        height: 30
        width: header_text.width+10
        radius: 10
        Text
        {
            id: header_text
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:  Text.AlignVCenter
            font.pointSize: 10
            color: "#ffaa00"
            font.family: "Comic Sans MS"
            //font.bold: true
            text: "Download Information"
        }
    }
    Rectangle
    {
        id:progress_graph_rec
        anchors.top: parent.top
        anchors.left: info_box.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: small_packets_graph.top
        //anchors.bottom: info_box.bottom
        anchors.bottomMargin: 10
        //border.color: "#ffffff"
        //border.width: 3
        //radius: download_progress_heading.radius
        color: "transparent"
        ChartView
        {
            id: chart
            title: "Protocol wise traffic division"
            titleColor: "#388e3c"
            titleFont.family:  "Comic Sans MS"
            titleFont.bold: true
            anchors.fill: parent
            legend.visible: false
            antialiasing: true
            backgroundColor: "transparent"
            theme: ChartView.ChartThemeQt
            PieSeries {
                id: pieSeries
                onClicked:
                {
                    if(currentlyExplodedLabel!="" && (currentlyExplodedGraphNumber==1))
                    {
                        pieSeries.find(currentlyExplodedLabel).exploded= false
                    }
                    else if(currentlyExplodedLabel!="" && (currentlyExplodedGraphNumber==2))
                    {
                        pieSeries1.find(currentlyExplodedLabel).exploded= false
                    }
                    currentlyExplodedLabel = slice.label
                    currentlyExplodedGraphNumber=1
                    slice.exploded = true
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "Ethernet"; value: ethPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "IPv6"; value: ipv6PacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "IPv4"; value: ipv4PacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "TCP"; value: tcpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "UDP"; value: udpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "DNS"; value: dnsPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "HTTP"; value: httpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "SSL"; value: sslPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#ede7f6"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "Others"; value: totalPackets-sumOfAllSupported
                    explodeDistanceFactor: 0.25
                }
            }
        }
    }
    Rectangle
    {
        id:small_packets_graph

        anchors.left: cancel_button.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        height: parent.height*0.35
        //anchors.bottom: info_box.bottom
        anchors.bottomMargin: 20
        //border.color: "#ffffff"
        //border.width: 3
        //radius: download_progress_heading.radius
        color: "transparent"
        ChartView
        {
            id: chart1
            //title: "Protocols with few packets"
            titleColor: "#388e3c"
            titleFont.family:  "Comic Sans MS"
            titleFont.bold: true
            anchors.fill: parent
            legend.visible: false
            antialiasing: true
            backgroundColor: "transparent"
            theme: ChartView.ChartThemeQt
            PieSeries {
                id: pieSeries1
                onClicked:
                {
                    if(currentlyExplodedLabel!="" && (currentlyExplodedGraphNumber==1))
                    {
                        pieSeries.find(currentlyExplodedLabel).exploded= false
                    }
                    else if(currentlyExplodedLabel!="" && (currentlyExplodedGraphNumber==2))
                    {
                        pieSeries1.find(currentlyExplodedLabel).exploded= false
                    }
                    currentlyExplodedLabel = slice.label
                    currentlyExplodedGraphNumber=2
                    slice.exploded = true
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#ff6f00"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "VOIP"; value: voipPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#ef5350"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "RTP"; value: rtpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#9c27b0"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "FTP"; value: ftpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#00796b"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "DHCP"; value: dhcpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#5c6bc0"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "ICMP"; value: icmpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "PPPOE"; value: pppoePacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "ARP"; value: arpPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "HTTPS"; value: httpsPacketCount
                    explodeDistanceFactor: 0.25
                }
                PieSlice
                {
                    labelColor: "#ffffff"
                    //color: "#4dd0e1"
                    labelFont.family: "Comic Sans MS"
                    labelFont.pointSize: 10
                    labelFont.letterSpacing: 1
                    labelVisible: true
                    label: "SIP"; value: sipPacketCount
                    explodeDistanceFactor: 0.25
                }
            }
        }
    }
    Rectangle
    {
        id: resume_pause_button
        color: "#21be2b"
        width: 150
        height: rp_button_text.height+20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right:  parent.horizontalCenter
        anchors.rightMargin: 30
        radius: height/2
        state: "notstarted"
        Image {
            id: rp_button_image
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            width: 20
            height: width
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.Stretch
        }
        Text
        {
            id: rp_button_text
            //anchors.left: rp_button_image.right
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 4
            anchors.verticalCenter: rp_button_image.verticalCenter
            font.family: "Comic Sans MS"
            //font.bold: true
            font.pointSize: 10

        }
        states: [
            State {
               name: "inactive"

               PropertyChanges {
                   target: rp_button_image
                   source: "pause-gray.png"
               }
               PropertyChanges
               {
                   target: rp_button_text
                   color: "#ffffff"
                   text: "Resume"
               }
            },
            State
            {
                name: "resumed"
                PropertyChanges {
                    target: rp_button_image
                    source: "qrc:/pause-white.png"
                }
                PropertyChanges{
                    target: rp_button_text
                    color: "#ffffff"
                    text: "Pause"
                }
            },
            State
            {
                name: "paused"
                PropertyChanges {
                    target: rp_button_image
                    source: "qrc:/play-white.png"
                }
                PropertyChanges{
                    target: rp_button_text
                    color: "#ffffff"
                    text: "Resume"
                }
            },
            State
            {
                name: "notstarted"
                PropertyChanges {
                    target: rp_button_image
                    source: "qrc:/play-white.png"
                }
                PropertyChanges{
                    target: rp_button_text
                    color: "#ffffff"
                    text: "Start"
                }
            }
            ]
        transitions: Transition {
            from: {
                if(resume_pause_button.state!="inactive")
                {
                    if(resume_pause_button.state=="resumed")
                    {
                        return "resumed"
                    }
                    else return "paused"
                }
                else return "inactive"
            }
            to: {
                if(resume_pause_button.state!="inactive")
                {
                    if(resume_pause_button.state=="resumed")
                    {
                        return "paused"
                    }
                    else return "resumed"
                }
                else return "inactive"
            }
            SmoothedAnimation
            {
                targets: [rp_button_image, rp_button_text]
                //properties: "source, text"
                duration: 500
                //easing.type: Easing.InBounce
            }
        }

        MouseArea
        {
            id: rp_button
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                if(parent.state=="notstarted")
                {
                    parent.state = "resumed";
                    cancel_button.state="active"
                    operationsHandler.startLiveAnalysis()
                    timer.start()
                }
                else if(parent.state=="resumed")
                {
                    parent.state="paused"
                    operationsHandler.pauseLiveAnalysis()
                    timer.stop()
                }
                else if(parent.state=="paused")
                {
                    parent.state="resumed"
                    cancel_button.state="active"
                    operationsHandler.startLiveAnalysis()
                    timer.start()
                }
            }
        }
    }
    Rectangle
    {
        id: cancel_button
        color: "#21be2b"
        width: resume_pause_button.width
        height: resume_pause_button.height
        //anchors.left: resume_pause_button.right
        //anchors.leftMargin: parent.width/90
        anchors.verticalCenter: resume_pause_button.verticalCenter
        radius: height/2
        anchors.left:  parent.horizontalCenter
        anchors.leftMargin: 30
        state: "inactive"
        Text
        {
            id: cancel_button_text
            anchors.centerIn: parent
            font.family: "Comic Sans MS"
            //font.bold: true
            font.pointSize: 10
            text: "Stop"
            color: "#ffffff"
        }
        states: [
            State {
               name: "inactive"

               PropertyChanges {
                   target: cancel_button
                   color: "#bbbbbb"
               }
            },
            State
            {
                name: "active"
                PropertyChanges{
                    target: cancel_button_text
                    color: "#ffffff"
                    text: "Stop"
                }
            }
            ]

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                if(parent.state=="active")
                {
                    operationsHandler.stopLiveAnalysis()
                }
            }
        }
    }
}

