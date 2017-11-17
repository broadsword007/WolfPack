#ifndef OPERATIONSHANDLER_H
#define OPERATIONSHANDLER_H

#include <QObject>
#include "stdlib.h"
#include "IpAddress.h"
#include "PcapLiveDeviceList.h"
#include "PlatformSpecificUtils.h"
#include "Packet.h"
#include "TcpLayer.h"
#include "UdpLayer.h"
#include <arpa/inet.h>
#include <QDebug>
#include <QDateTime>
class OperationsHandler : public QObject
{
    Q_OBJECT
    struct PacketStats
    {
        /// Packet Count
        long ethPacketCount;
        long ipv4PacketCount;
        long ipv6PacketCount;
        long tcpPacketCount;
        long udpPacketCount;
        long dnsPacketCount;
        long httpPacketCount;
        long sslPacketCount;

        long sipPacketCount ;

        int voipPacketCount;
        long rtpPacketCount;
        long ftpPacketCount;
        long dhcpPacketCount;
        long icmpPacketCount;
        long pppoePacketCount;
        long arpPacketCount;
        long httpsPacketCount;

        long totalPackets ;
        long lastSIPPacketArrivedAtPosition;

        /// LastRecieved
        QString ethLastPacketRecievedTime;
        QString ipv4LastPacketRecievedTime;
        QString ipv6LastPacketRecievedTime;
        QString tcpLastPacketRecievedTime;
        QString udpLastPacketRecievedTime;
        QString dnsLastPacketRecievedTime;
        QString httpLastPacketRecievedTime;
        QString sslLastPacketRecievedTime;

        QString sipLastPacketRecievedTime ;

        QString voipLastPacketRecievedTime;
        QString rtpLastPacketRecievedTime;
        QString ftpLastPacketRecievedTime;
        QString dhcpLastPacketRecievedTime;
        QString icmpLastPacketRecievedTime;
        QString pppoeLastPacketRecievedTime;
        QString arpLastPacketRecievedTime;
        QString httpsLastPacketRecievedTime;

    public:
        /**
         * Clear all stats
         */
        void clear()
        {
            voipPacketCount =0 ;
            rtpPacketCount = 0;
            ftpPacketCount = 0;
            dhcpPacketCount = 0;
            icmpPacketCount = 0;
            pppoePacketCount = 0;
            arpPacketCount = 0;
            httpsPacketCount = 0;

            sipPacketCount = 0;

            ethPacketCount = 0; //
            ipv4PacketCount = 0; //
            ipv6PacketCount = 0; //
            tcpPacketCount = 0; //
            udpPacketCount = 0;
            dnsPacketCount = 0;
            httpPacketCount = 0;
            sslPacketCount = 0;

            totalPackets=0;
            lastSIPPacketArrivedAtPosition=0;
        }

        /**
         * C'tor
         */
        PacketStats() { clear(); }
        pcpp::tcphdr* extractTcpHeaderFromPacket(pcpp::Packet& packet)
        {
            pcpp::Layer* layer ;
            if (packet.isPacketOfType(pcpp::TCP))
            {
                layer = packet.getLayerOfType<pcpp::TcpLayer>();
                return ((pcpp::TcpLayer*)layer)->getTcpHeader();
            }
            else
            {
                qDebug()<<"The packet does not have a TCP Layer"<<endl ;
                return NULL ;
            }
        }
        pcpp::udphdr* extractUdpHeaderFromPacket(pcpp::Packet& packet)
        {
            pcpp::Layer* layer ;
            if (packet.isPacketOfType(pcpp::UDP))
            {
                layer = packet.getLayerOfType<pcpp::UdpLayer>();
                return ((pcpp::UdpLayer*)layer)->getUdpHeader();
            }
            else
            {
                qDebug()<<"The packet does not have a UDP Layer"<<endl ;
                return NULL ;
            }
        }
        /**
         * Collect stats from a packet
         */
        void consumePacket(pcpp::Packet& packet)
        {
            pcpp::tcphdr * tcpHeader= NULL ;
            pcpp::udphdr * udpHeader = NULL ;
            bool isHttp =false ;
            QString currentTime = QDateTime::currentDateTime().toString();
            if (packet.isPacketOfType(pcpp::Ethernet))
            {
                ethPacketCount++;
                ethLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::IPv4))
            {
                ipv4PacketCount++;
                ipv4LastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::IPv6))
            {
                ipv6PacketCount++;
                ipv6LastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::TCP))
            {
                tcpPacketCount++;
                tcpLastPacketRecievedTime= currentTime;
                tcpHeader = extractTcpHeaderFromPacket(packet);
            }
            if (packet.isPacketOfType(pcpp::UDP))
            {
                udpPacketCount++;
                udpLastPacketRecievedTime= currentTime;
                udpHeader = extractUdpHeaderFromPacket(packet);
            }
            if (packet.isPacketOfType(pcpp::DNS))
            {
                dnsPacketCount++;
                ethLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::HTTP))
            {
                isHttp = true ;
                httpPacketCount++;
                httpLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::SSL))
            {
                sslPacketCount++;
                sslLastPacketRecievedTime= currentTime;
                if(isHttp) // Both HTTP and SSL -> HTTPS
                {
                    httpsPacketCount++;
                }
            }
            if (packet.isPacketOfType(pcpp::SIP))
            {
                sipPacketCount++;
                sipLastPacketRecievedTime= currentTime;
                lastSIPPacketArrivedAtPosition = totalPackets;
            }
            if (packet.isPacketOfType(pcpp::DHCP))
            {
                dhcpPacketCount++;
                dhcpLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::ICMP))
            {
                icmpPacketCount++;
                icmpLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::PPPoE))
            {
                pppoePacketCount++;
                pppoeLastPacketRecievedTime= currentTime;
            }
            if (packet.isPacketOfType(pcpp::ARP))
            {
                arpPacketCount++;
                arpLastPacketRecievedTime= currentTime;
            }
            if(tcpHeader)
            {
                if(tcpHeader->portDst == 5060 || tcpHeader->portDst == 5061 ||
                   tcpHeader->portSrc == 5060 || tcpHeader->portSrc == 5061)
                {
                    voipLastPacketRecievedTime= currentTime;
                    voipPacketCount++;
                }
                if(tcpHeader->portDst == 20 || tcpHeader->portDst == 21 ||
                   tcpHeader->portSrc == 20 || tcpHeader->portSrc == 21)
                {
                    ftpLastPacketRecievedTime= currentTime;
                    ftpPacketCount++;
                }
            }
            else if(udpHeader)
            {
                if((udpHeader->portDst>1024 && udpHeader->portSrc<65535) &&
                        (lastSIPPacketArrivedAtPosition!=0 && totalPackets-lastSIPPacketArrivedAtPosition<10))
                { // If is a UDP packet and SIP packet was arrived recently
                    rtpLastPacketRecievedTime= currentTime;
                    rtpPacketCount++;
                }
            }
            totalPackets++;
        }

        /**
         * Print stats to console
         */
        void printToConsole()
        {
            printf("Ethernet packet count: %d\n", ethPacketCount);
            printf("IPv4 packet count:     %d\n", ipv4PacketCount);
            printf("IPv6 packet count:     %d\n", ipv6PacketCount);
            printf("TCP packet count:      %d\n", tcpPacketCount);
            printf("UDP packet count:      %d\n", udpPacketCount);
            printf("DNS packet count:      %d\n", dnsPacketCount);
            printf("HTTP packet count:     %d\n", httpPacketCount);
            printf("SSL packet count:      %d\n", sslPacketCount);
        }
    };
    static void onPacketArrives(pcpp::RawPacket* packet, pcpp::PcapLiveDevice* dev, void* cookie)
    {
        // extract the stats object form the cookie
        PacketStats* stats = (PacketStats*)cookie;

        // parsed the raw packet
        pcpp::Packet parsedPacket(packet);

        // collect stats from packet
        stats->consumePacket(parsedPacket);
    }
    PacketStats * packetAnayzer ;
    pcpp::PcapLiveDevice* dev;
public:
    Q_INVOKABLE long getEthPacketCount();
    Q_INVOKABLE long getIpv4PacketCount();
    Q_INVOKABLE long getIpv6PacketCount();
    Q_INVOKABLE long getTcpPacketCount();
    Q_INVOKABLE long getUdpPacketCount();
    Q_INVOKABLE long getDnsPacketCount();
    Q_INVOKABLE long getHttpPacketCount();
    Q_INVOKABLE long getSslPacketCount();
    Q_INVOKABLE long getSipPacketCount();
    Q_INVOKABLE long getVoipPacketCount();
    Q_INVOKABLE long getRtpPacketCount();
    Q_INVOKABLE long getFtpPacketCount();
    Q_INVOKABLE long getDhcpPacketCount();
    Q_INVOKABLE long getIcmpPacketCount();
    Q_INVOKABLE long getPppoePacketCount();
    Q_INVOKABLE long getArpPacketCount();
    Q_INVOKABLE long getHttpsPacketCount();
    Q_INVOKABLE long getTotalPackets();

    Q_INVOKABLE QString getEthLastPacketRecievedTime();
    Q_INVOKABLE QString getIpv4LastPacketRecievedTime();
    Q_INVOKABLE QString getIpv6LastPacketRecievedTime();
    Q_INVOKABLE QString getTcpLastPacketRecievedTime();
    Q_INVOKABLE QString getUdpLastPacketRecievedTime();
    Q_INVOKABLE QString getDnsLastPacketRecievedTime();
    Q_INVOKABLE QString getHttpLastPacketRecievedTime();
    Q_INVOKABLE QString getSslLastPacketRecievedTime();
    Q_INVOKABLE QString getSipLastPacketRecievedTime();
    Q_INVOKABLE QString getVoipLastPacketRecievedTime();
    Q_INVOKABLE QString getRtpLastPacketRecievedTime();
    Q_INVOKABLE QString getFtpLastPacketRecievedTime();
    Q_INVOKABLE QString getDhcpLastPacketRecievedTime();
    Q_INVOKABLE QString getIcmpLastPacketRecievedTime();
    Q_INVOKABLE QString getPppoeLastPacketRecievedTime();
    Q_INVOKABLE QString getArpLastPacketRecievedTime();
    Q_INVOKABLE QString getHttpsLastPacketRecievedTime();

    Q_INVOKABLE void startLiveAnalysis();
    Q_INVOKABLE void pauseLiveAnalysis();
    Q_INVOKABLE void stopLiveAnalysis();
    explicit OperationsHandler(QObject *parent = nullptr);

signals:

public slots:
};

#endif // OPERATIONSHANDLER_H
