#import "@preview/note-me:0.5.0": *

= Service quotas

Each service has a default per-region quota, some service can be per account.
Most service quotas can be increased as needed.

#important[
  Some quotas can't be changed, it's important to know about these as they can affect architecture decisions.

  Example: IAM users per account has a hard limit of 5000
]

The quotas can be increased, but keep in mind that the higher the increase, the more process and time will be needed to do so.

== Quota request templates

These are templates that will be applied to each new account that is created within the AWS ORG.
It is possible to defined required quotas beforehand, and these will be applied to each new account which is created.

This saves time by preventing a manual step of requesting each service quota increase manually.

== Useful links

- #link("https://docs.aws.amazon.com/general/latest/gr/aws-service-information.html")[Service endpoints and quotas]
- See the console UI: Service Quotas -> AWS Services
- #link("https://docs.aws.amazon.com/servicequotas/latest/userguide/organization-templates.html")[Using Service Quota request templates]
- #link("https://docs.aws.amazon.com/servicequotas/latest/userguide/configure-cloudwatch.html")[Service Quotas and CloudWatch Alarms]
- #link("https://awscli.amazonaws.com/v2/documentation/api/latest/reference/service-quotas/list-service-quotas.html")[AWS CLI - list-service-quotas]
- #link("https://awscli.amazonaws.com/v2/documentation/api/latest/reference/service-quotas/list-aws-default-service-quotas.html")[AWS CLI - list-aws-default-service-quotas]
- #link("https://awscli.amazonaws.com/v2/documentation/api/latest/reference/service-quotas/request-service-quota-increase.html")[AWS CLI - request-service-quota-increase]
