#import "@preview/note-me:0.5.0": *
#import "@preview/zero:0.5.0": set-group, num

#set-group(separator: ",", threshold: 4)

= Authentication & Authorization

== IAM (Identity and Access Management)

=== Permissions Boundaries

Only *identity* permissions are impacted by boundaries, any resource policy is applied in full.
They can be applied to *users* and *roles*, and don't grant any access, they defined the maximum permissions an identity can receive.

Permissions that are outside of the boundary will have no effect on that identity.

The most useful case here to use permissions boundaries is for delegation.
When you want to provide a user with access to IAM, there is nothing stopping that user from assigning a role to himself with greater permissions.

=== Policy evaluation logic

#figure(image("./images/iam-policy-evaluation.png"), caption: [IAM; Policy evaluation logic])

#figure(image("./images/iam-multi-account-policy-evaluation.png"), caption: [IAM; Multi-account policy evaluation logic])

=== Links

- #link("https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html")[Reference policy variables]

== Identity Federation

Identity federation is the ability to use an external identity provider (IdP) to grant access to AWS resources.
Only AWS credentials can be used to access AWS resources, and so some form of exchange is required.

=== SAML 2.0

SAML stands for Security Assertion Markup Language.
It's an open standard used by many IdP's, such as the Microsoft ADFS (Active Directory Federation Services).
It is possible to *indirectly* use on-premise IDs with AWS (Console & CLI)

#tip(title: "Exam power-up")[
  This would be used with an Enterprise Identity Provider which is SAML 2.0 compatible.

  *or*

  There is already an existing identity management team, which needs to be maintained.

  *or*

  There needs to be single source of truth or there are more than 5000 users present.
]

IAM Federation used IAM Roles and AWS Temporary Credentials, which typically have up to 12 hours of validity.

==== Architecture examples

#figure(image("./images/iam-federation-saml-api.png"), caption: [IAM; Federation SAML for AWS API])

#figure(image("./images/iam-federation-saml-console.png"), caption: [IAM; Federation SAML for AWS Console])

=== IAM Identity center

This service enables a centralized way to manage SSO access to multiple AWS accounts managed by AWS Organization and external (business) applications.

It provides flexible Identity Sources, such as:
- AWS SSO - Built-in identity store
- AWS Managed Microsoft AD
- On-premise Microsoft AD (two way trust or AD connector)
- External IdP (SAML 2.0)

#tip(title: "Exam power-up")[
  This service is preferred by AWS, compared to the traditional 'workforce' identity federation.
  This service handles all the permissions within your organization, which provides significantly less admin-overhead.
]

#figure(image("./images/iam-federation-identity-center.png"), caption: [IAM; Federation with IAM Identity Center])

=== Amazon Cognito

This service provides authentication, authorization and user-management for web/mobile apps.

User-pool provide sign and the retrieval of a JSON web token (JWT).
They don't grant access to AWS resources, it manages user-directory and profiles, sign-up and sign-in with a customizable UI, MFA and other security features.

#tip(title: "Exam power-up")[
  Think of user-pools as a database of users, which can include external identities.
]

Identity-pools is capable of offering access to temporary AWS credentials to access AWS resources.

It is possible to provide Unauthenticated identities, which can be seen as guest users.
This is useful when you want to provide publicly accessible services (such as a leaderboard).

There are also Federated Identities, which is the ability to use external IdP's (such as Google, Facebook, Amazon, SAML 2.0 or OpenID Connect) or user-pool.
This provides the ability to swap your JWT for short term AWS credentials.

==== Architecture example

#figure(image("./images/cognito-user-pool.png"), caption: [Cognito; User Pool])

#figure(image("./images/cognito-identity-pool.png"), caption: [Cognito; Identity Pool])

#figure(image("./images/cognito-user-and-identity-pool.png"), caption: [Cognito; User & Identity Pool])

=== Directory Service

==== #link("https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_microsoft_ad.html")[Microsoft AD]

This mode is built using native Microsoft Active Directory 2019. It runs within a VPC, in subnets that are defined by the user.
It can be managed by using standard active directory tools.

Supports: 
- Group policy and single sign-on
- Schema extention - MS AD Aware apps
  - Sharepoint, SQL or Distributed File System (DFS)

It comes with 2 sizes provided by AWS:
- Standard with up to #num(30000) objects
- Enterprise with up to #num(500000) objects

In general the mode is used for AD authentication/authorization of products and services within AWS.
The use case for using this type, is if there is a requirement for native Microsoft AD support.

It is HA by default, being deploy in 2 or more availability zones, with one domain controller in each AZ.
Because it is a managed AWS service it comes with a list of features (which are all configurable); monitoring, recovery, replication, snapshots and maintenance.

This mode supports one-way and two-way external and forest trusts with on-premises AD. 
It is still a directory service *in* AWS, so if the network link between AWS and on-premises goes down, the AD in AWS will still work.
It also supports RADIUS-based MFA.

#tip(title: "Exam power-up")[
  Best choice for more than #num(5000) users and trust relationships and required between AWS and the on-premises AD.
]

#figure(
  image("./images/directory-service-microsoft-ad.png"),
  caption: [Directory Service; Microsoft AD]
)

==== AD Connector

This mode provides a pair of directory endpoints running in AWS, it injects 2 ENIs into your VPC across 2 AZ.
It support directory-aware AWS products, such as Workspaces and WorkDocs.

The AD connecter redirects the requests to the existing directory servers.
This means no directory data is stored within AWS, everything is redirected.

With this mode, it is possible to use existing on-premises AD with directory compatible AWS Services, without any identity data in AWS.

This mode is ideal for proof of concepts, by using existing identites and having minimal admin overhead.

There are two sizes, small and large, but there are no explicit limits, it does control the amount of compute allocated.
Multiple AD Connectors can be deployed to spread the load.

AD connectery requires 2 subnets within a VPC, each in a different AZ. It requires one or more directory servers to be configured.

#warning[
  This requires a *working* network connection for this to keep working.
  If this is not working, it will be impossible to access services which require the AD authentication.
]

The network connectivity either runs through a Direct Connect or through a site-to-site VPN.

#figure(
  image("./images/directory-service-ad-connector.png"),
  caption: [Directory Service; AD Connector]
)
