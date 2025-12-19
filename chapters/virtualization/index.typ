#import "@preview/note-me:0.5.0": note

= Virtualization

== Amazon WorkSpaces

It is a Desktop-as-a-Service (DaaS) solution, which provides a cloud-based virtual desktop experience.
Similar to to Citrix and Remote Desktop, only it hosted by AWS.

It's a consistent desktop from anywhere, after logging off and logging back in, the apps and their state are maintained.

This service provides access to Windows and Linux environments, of various sized (CPU, Memory or GPU).
These can come with or without AWS provided Apps and Custom Images.

=== Pricing

There's either an monthly or hourly price, plus a base infrastructure cost.

#note[
  The hourly charing model allows suspending of the workspace when it's not in use.
  Keep in mind however that there is a base-monthly infrastructure cost in addition to the normal hourly rate.
]

=== Misc

The service uses the Directory Service (Simple, AD or AD Connector) for authentication and user-management.

Workspaces use an ENI (Elastic Network Interface) in a VPC, and it uses any network associated infrastructure.
Connection to a workspace is done through a client application, and bandwidth to the client is free of charge. Any network traffic within the VPC will be charged at normal price.

Windows Workspaces can access windows based VPC resources; such as FSx and EC2, but it can also access on-premise resources over VPN or Direct Connect.

Workspaces provide both system and user storage, and both of these can be encrypted at rest (using EBS + KMS).

Linux and web-based access is disabled by default, see #link("https://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces.html")[
  Amazon WorkSpaces documentation
]

=== Architecture

#figure(image("./images/workspaces-architecture.png"), caption: [Amazon WorkSpaces; Architecture])
