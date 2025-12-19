= Organization resources

This chapter covers the resources that are mainly used to manage resources across the organization or the setup thereof.

== Control Tower

Control Tower is a service that is used for quick and easy setup of multi-account environments.
It orchestrates different services to it's job, such as AWS Organizations, IAM Identity Center, AWS Config, CloudFormation, etc.

On one hand, there is the landing zone. This is where you can setup the accounts, connect SSO and view the logging of the account (which uses CloudWatch, CloudTrails, AWS Config and SNS).
Next to this, it also has Guardrails, which are rules to detect and/or mandate certain rules and standards across all accounts.
The Account Factory provides a way to create account in automatic and standardized way.
Finally, there is the dashboard, which provides a central overview of the setup.

=== Landing zone

This is the zone where the home-region is defined (e.g., us-east-1) and where the core accounts are created.
It utilizes AWS Organizations, AWS Config and CloudFormation.

There are by default 2 Organizational Units (OU's):
- Security OU: contains the log archive and audit accounts.
- Sandbox OU: contains testing accounts with less rigid security.

It is possible to create different OU's, but this depends on the need of the organization itself.

=== Guardrails

Guardrails are rules, which are used for multi-account governance.
The types of guardrails are: mandatory (must be applied), strongly recommended (should be applied) and elective (may be applied).

Guardrails function in different way:
- Preventive: stop the user from doing things (using Service Control Policies, part of AWS Organizations).
  - This can be allowing or denying the usage of certain regions, or prevent bucket-policy changes.
- Detective: detect non-compliance (using AWS Config rules).
  - These types of Guardrails are either `clear`, `in violation` or `not enabled`
  - It could be used, for example, to detect if CloudTrail is enabled

=== Account Factory

This helps with the automated provisioning of accounts. It could either be started by admins or by end-users (with appropriate permission).
The following can be done using the account factory:
- Guardrails automatically applied
- Account admin given to a named user (using IAM Identity Center)
- Account and network standard configurations (using Service Catalog)
- Accounts can be closed or repurposed
- Can also be fully integrated with businesses' software development lifecycle (SDLC)

=== Architecture

#figure(image("./images/control-tower-architecture.png"), caption: [Control Tower; Architecture overview])
