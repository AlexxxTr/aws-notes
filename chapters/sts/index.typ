
#import "@preview/note-me:0.5.0": *

= STS (Security token service)

This generates temporary credentials using the sts:AssumeRole call.
It is similar to access keys, in that it has an access key id (public) and a secret access key (private). The key difference is that they expire.
They provide access for a limited to AWS resources and they can be request by an Identity (aws or external, e.g. web identity federation).

== Assuming a role

A role that can be assumed has a trust policy, this policy defines who can assume the role.
If a call is made by an identity which is not trusted, the call will fail.
These calls can be made by an iam user, aws resource, or an external identity (e.g. web identity federation).

The iam-role will return the permission policy, this controls what the role is allowed or denied to do inside aws.

STS generates temporary security credentials that consist of an access key ID, a secret access key, and a session token.
There is also an expiration time returned, which tells when the credentials will expire.

These credentials will provide temporary access which are authorized in the permissions policy of the role.

- *access key id*: unique id of the credentials
- *secret access key*: used to sign requests
- *session token*: unique token which mst be passed with all requests

When the credentials expire, a new called to STS needs to be made to assume the role and retrieve new credentials.

== Revoking IAM Role Temporary Credentials

Temporary credentials cannot be cancelled, they are valid until they expire.
If you delete the used role, or change the permissions of that role, that impacts everyone who has assumed that role.

If credentials are leaked, changing the trust policy will not fix this. This is only used when assuming the role, not when using the credentials.

It is possible to apply the AWSRevokeOlderSession inline DENY, which denies any activity for sessions *older* than *NOW*.
#note[
  This policy is a conditional, which states that sessions assumed before a certain date cannot be used. This still means that the credentials that are out in the field are still valid, but they can't be used because they don't match the condition.
  Explicit DENY takes precedence over any ALLOW.
]
