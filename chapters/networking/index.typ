#import "@preview/note-me:0.5.0": *

= Networking

This chapter covers the posibilites with networking (vpc, hybrid, etc), and goes deeper in each subsection.

== DHCP in a VPC

DHCP stands for Dynamic Host Configuration Protocol. It is a network management protocol used to automate the process of configuring devices on IP networks.
Devices start with a layer 2 broadcast to get info from the the DHCP server. It provides an IP adress, subnet mask and a default gateway.

Within a VPC, it also provides DNS Servers and a custom domain name. 
NTP Server are also configured for time-syncronization, and also has the posibility for NetBios Name Server & Node Types, but these are only configured when using the NetBios protocol.

#figure(image("./images/vpc-dhcp.png"), caption: [VPC; DHPC Architecture])

== VPC Router

The VPC Router is a virutal router within a VPC, which is highly available across all AZ's in that region.
It's a scalable service wher eno performance management is required.

The router has several purposes:
- routes traffic between subnets
- routes traffic *from external* networks *into* the VPC
- routes traffic *from the VPC* into *external networks* (it still needs an internet gateway to go the public internet, but it controls the traffic within the vpc)

It has an network interface within each subnet, and receives the 'subnet+1' address (default GW via DHCP Option Set).
It's possible to control the routes within the router, using route tables (see @route-tables).

#figure(image("./images/vpc-router.png"), caption: [VPC; VPC Router Architecture])

=== Route tables <route-tables>

Every VPC is created with a main Route Table (RT), which is the default for every subnet in the VPC.
Custom route tables can created and associated with subnets in a VPC, but this removed the association with main route table.
Subnets are only associated with *one* route table, this could be the main or custom RT.

#tip[
  The default (main) route table should be left with it's default state.
  Any custom route tables can be explicitely associated with a subnet.

  When remvoing the custom route table from the subnet, they receive the main route table, and this could cause them to have uninteded access to certain routes.
  This could be seen as a security risk.
]

The route table contains routes, with the most specific route being applied first.
The only exception to this rule, are local routes. If these match, they will always take priority.

== Security

=== Firewalls (stateful vs stateless)

Image a scenario where a user is making a request to a server. It's often assumed that this one *single outbound* connection (e.g. TCP, port 443).
In actuallity, every conection has two parts, *request* (initiation) and *response*.

#figure(image("./images/vpc-visual-tcp-connection.png"), caption: [VPC; Visual TCP connection])

It has been talked about the a connection consists of a request and a response, but it's also important to note the directionality of each of these parts.
What is meant by directionality, is *INBOUND* or *OUTBOUND*, and this depends on the perspective (CLIENT / SERVER).

#figure(image("./images/vpc-visual-tcp-directionality.png"), caption: [VPC; Visual TCP directionality])

The main difference bewteen stateless and stateful firewalls, is that the stateless sees the request and response as 2 different things, it does not understand their association.
While the stateful firewall does understand how they work together, meaning less configuration and easier to manage.

In a stateless firewall, it is also important to consider the direction of the request, this could be both inbound and outbout, meaning that it's likely you have to allow the full range of ephameral ports.

#figure(image("./images/vpc-stateless-firewall.png"), caption: [VPC; Stateless firewall])

#figure(image("./images/vpc-stateful-firewall.png"), caption: [VPC; Stateful firewall])
