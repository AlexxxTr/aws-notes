#import "@preview/note-me:0.5.0": *

= RAM (Resource access manager)

This service enables you to share your resources with other AWS accounts or within your AWS Organization.
The product/service needs to support RAM, and these can be shared with Principals (accounts, OU's or organization).

The shared resources can be accessed natively, which means they will be visible within the console UI and through the CLI.

#note[
  There is no charge for using RAM, there's only a charge for the service cost itself.
]

RAM enable substantial changes to traditional AWS architectures.

== Sharing

The owner account will create a share, which is a resource, and provides this with a name.
The owner account will retain full ownership over the resource being shared.
When creating a share, it is required to define a principal with whom to share it with.

#note[
  If the share is shared with a principal in the same ORG, with sharing enabled, then the share is automatically accepted.
  If the share is shared with a principal who is not in the same ORG, or in an ORG where sharing is *not* enabled, then the principal will receive an invite and will need to accept that invite to use the resource.
]

#warning[
  Each participant owns their own created resources within the share, and they are not visible by other participants.

  Participants cannot make changes to shared resources, they can only reference and use them, but no modification or deletion can be done.
]

#tip(title: "Exam power-up")[
  Some resources can be shared with *ANY* account, some can ony be shared with AWS ORG accounts.
]

=== Shared Service VPC example

#figure(image("./images/ram-shared-service-vpc-example.png"), caption: [RAM: Shared Service VPC example])
