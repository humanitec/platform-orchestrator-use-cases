# Infrastructure drift detection

The Platform Orchestrator can remediate infrastructure drift by detecting resources having drift and re-aligning them with the desired state through a re-deployment.

> ℹ️ **Note**
> 
> The use case implementation on Terraform/OpenTofu is currently being prepared. We are publishing the use case description ahead of time to illustrate the Orchestrator capabilities to interested users.

## Scenario: slow Redis

Alex the platform engineer is doing a casual sweep through Grafana, most panels look calm and green, but one card stands out in that annoying "I’m not broken but I’m not right either" orange. It’s the `notifications-worker` dashboard. 

The Grafana panel reads: `Job processing P95 latency 38 percent above the threshold.`

However, there is no CPU spike and no traffic surge.

But right next to the latency panel is a little yellow badge that was not there yesterday: `Drift Status: 1 drift detected in this environment (via Humanitec)`

Using a deeplink to the application’s staging environment on Humanitec, Alex can see the drift details on Humanitec too and can remediate it by a re-deployment.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec-tf-modules)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->