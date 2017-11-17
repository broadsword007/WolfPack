#include "operationshandler.h"
OperationsHandler::OperationsHandler(QObject *parent) : QObject(parent)
{
    std::string interfaceIPAddr = "192.168.0.121";
    // find the interface by IP address
    dev = pcpp::PcapLiveDeviceList::getInstance().getPcapLiveDeviceByIp(interfaceIPAddr.c_str());
    if (dev == NULL)
    {
        printf("Cannot find interface with IPv4 address of '%s'\n", interfaceIPAddr.c_str());
        exit(1);
    }

    // Get device info
    // ~~~~~~~~~~~~~~~

    // before capturing packets let's print some info about this interface
    printf("Interface info:\n");
    // get interface name
    printf("   Interface name:        %s\n", dev->getName());
    // get interface description
    printf("   Interface description: %s\n", dev->getDesc());
    // get interface MAC address
    printf("   MAC address:           %s\n", dev->getMacAddress().toString().c_str());
    // get default gateway for interface
    printf("   Default gateway:       %s\n", dev->getDefaultGateway().toString().c_str());
    // get interface MTU
    printf("   Interface MTU:         %d\n", dev->getMtu());
    // get DNS server if defined for this interface
    if (dev->getDnsServers().size() > 0)
        printf("   DNS server:            %s\n", dev->getDnsServers().at(0).toString().c_str());

    // open the device before start capturing/sending packets
    if (!dev->open())
    {
        printf("Cannot open device\n");
        exit(1);
    }

    // create the stats object
    packetAnayzer = new PacketStats;
}
void OperationsHandler::startLiveAnalysis()
{
    // start capture in async mode. Give a callback function to call to whenever a packet is captured and the stats object as the cookie
    printf("\nStarting async capture...\n");
    dev->startCapture(onPacketArrives, packetAnayzer);
}
void OperationsHandler::pauseLiveAnalysis()
{
    dev->stopCapture();
}
void OperationsHandler::stopLiveAnalysis()
{
    dev->stopCapture();
    printf("Results:\n");
    packetAnayzer->printToConsole();
    packetAnayzer->clear();
}
long OperationsHandler::getEthPacketCount()
{
    return packetAnayzer->ethPacketCount;
}
long OperationsHandler::getIpv4PacketCount()
{
    return packetAnayzer->ipv4PacketCount;
}
long OperationsHandler::getIpv6PacketCount()
{
    return packetAnayzer->ipv6PacketCount;
}
long OperationsHandler::getTcpPacketCount()
{
    return packetAnayzer->tcpPacketCount;
}
long OperationsHandler::getUdpPacketCount()
{
    return packetAnayzer->udpPacketCount;
}
long OperationsHandler::getDnsPacketCount()
{
    return packetAnayzer->dnsPacketCount;
}
long OperationsHandler::getHttpPacketCount()
{
    return packetAnayzer->httpPacketCount;
}
long OperationsHandler::getSslPacketCount()
{
    return packetAnayzer->sslPacketCount;
}
long OperationsHandler::getSipPacketCount()
{
    return packetAnayzer->sipPacketCount;
}
long OperationsHandler::getVoipPacketCount()
{
    return packetAnayzer->voipPacketCount;
}
long OperationsHandler::getRtpPacketCount()
{
    return packetAnayzer->rtpPacketCount;
}
long OperationsHandler::getFtpPacketCount()
{
    return packetAnayzer->ftpPacketCount;
}
long OperationsHandler::getDhcpPacketCount()
{
    return packetAnayzer->dhcpPacketCount;
}
long OperationsHandler::getIcmpPacketCount()
{
    return packetAnayzer->icmpPacketCount;
}
long OperationsHandler::getPppoePacketCount()
{
    return packetAnayzer->pppoePacketCount;
}
long OperationsHandler::getArpPacketCount()
{
    return packetAnayzer->arpPacketCount;
}
long OperationsHandler::getHttpsPacketCount()
{
    return packetAnayzer->httpsPacketCount;
}
long OperationsHandler::getTotalPackets()
{
    return packetAnayzer->totalPackets;
}

//////////////////////////////////////////////////////////////
QString OperationsHandler::getEthLastPacketRecievedTime()
{
    return packetAnayzer->ethLastPacketRecievedTime;
}
QString OperationsHandler::getIpv4LastPacketRecievedTime()
{
    return packetAnayzer->ipv4LastPacketRecievedTime;
}
QString OperationsHandler::getIpv6LastPacketRecievedTime()
{
    return packetAnayzer->ipv6LastPacketRecievedTime;
}
QString OperationsHandler::getTcpLastPacketRecievedTime()
{
    return packetAnayzer->tcpLastPacketRecievedTime;
}
QString OperationsHandler::getUdpLastPacketRecievedTime()
{
    return packetAnayzer->udpLastPacketRecievedTime;
}
QString OperationsHandler::getDnsLastPacketRecievedTime()
{
    return packetAnayzer->dnsLastPacketRecievedTime;
}
QString OperationsHandler::getHttpLastPacketRecievedTime()
{
    return packetAnayzer->httpLastPacketRecievedTime;
}
QString OperationsHandler::getSslLastPacketRecievedTime()
{
    return packetAnayzer->sslLastPacketRecievedTime;
}
QString OperationsHandler::getSipLastPacketRecievedTime()
{
    return packetAnayzer->sipLastPacketRecievedTime;
}
QString OperationsHandler::getVoipLastPacketRecievedTime()
{
    return packetAnayzer->voipLastPacketRecievedTime;
}
QString OperationsHandler::getRtpLastPacketRecievedTime()
{
    return packetAnayzer->rtpLastPacketRecievedTime;
}
QString OperationsHandler::getFtpLastPacketRecievedTime()
{
    return packetAnayzer->ftpLastPacketRecievedTime;
}
QString OperationsHandler::getDhcpLastPacketRecievedTime()
{
    return packetAnayzer->dhcpLastPacketRecievedTime;
}
QString OperationsHandler::getIcmpLastPacketRecievedTime()
{
    return packetAnayzer->icmpLastPacketRecievedTime;
}
QString OperationsHandler::getPppoeLastPacketRecievedTime()
{
    return packetAnayzer->pppoeLastPacketRecievedTime;
}
QString OperationsHandler::getArpLastPacketRecievedTime()
{
    return packetAnayzer->arpLastPacketRecievedTime;
}
QString OperationsHandler::getHttpsLastPacketRecievedTime()
{
    return packetAnayzer->httpsLastPacketRecievedTime;
}

////////////////////////////////////////////////////////////////
