# Public S3 buckets incident (impact analysis)

The Platform Orchestrator can remediate infrastructure drift by detecting resources having drift and re-aligning them with the desired state through a re-deployment.

> ℹ️ **Note**
> 
> The use case implementation on Terraform/OpenTofu is currently being prepared. We are publishing the use case description ahead of time to illustrate the Orchestrator capabilities to interested users.

## Scenario

Midweek rolls around and Alex the platform engineer is checking Grafana's security dashboards to make sure they are not accidentally on the front page of Hacker News. While doing so, he notices a new spike in "publicly accessible resources" flagged by their cloud posture scans.

Wait… what? That number is supposed to be zero. Alex drills into the alert and sees the culprit: The module responsible for provisioning S3 buckets has a misconfiguration. It's setting the default ACL to `public-read`.

Some workloads already consumed that module version. Others are on older versions. The blast radius is unclear. Alex introduces the fix in TF to enforce private access, and pushes the change.

Now the big question is:

How many environments are currently using the broken version? Which ones need to be updated?

Alex jumps into the "impact analysis" view on the Platform Orchestrator, where he can see: 

- The workloads relying on the module, and exactly which environments are using it
- and which teams own those workloads

The snapshot looks something like:

- Two dev environments for Team Atlas using the risky module
- A staging environment for Team Nova on the same version
- Four ephemeral environments for Team Mercury, two affected, two not
- Production environments across all teams unaffected (thankfully using an older, safe version)

The Humanitec Platform Orchestrator visualizes exactly which environments will be updated, which ones are safe, and what the delta looks like. Alex can finally breathe. He understands the scope of changes, and in case of a forced rollout, how much he might potentially break. No guessing. No sleuthing in repos.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec-tf-modules)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->