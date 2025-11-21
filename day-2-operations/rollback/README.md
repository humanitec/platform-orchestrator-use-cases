#  Rollback

The Platform Orchestrator can remediate application or infrastructure issues introduced by faulty deployments by executing a rollback to a previous, stable configuration.

> ℹ️ **Note**
> 
> The use case implementation on Terraform/OpenTofu is currently being prepared. We are publishing the use case description ahead of time to illustrate the Orchestrator capabilities to interested users.

## Scenario: the bad deploy (and the rollback)

Alex the platform engineer is sipping coffee when Grafana suddenly lights up like a crime scene on a Monday morning. The `payments-api` panel is deep red, error rate spiking hard.

Alex digs into the Grafana dashboard and sees a recent deploy correlates almost perfectly with the spike.

Alex flips to Humanitec, opens the `payments-api` deployment history on the production env, and sees:

- Application version updated
- Postgres dependency updated at the same time

This is bad. But Alex just hits “Rollback to previous release”. The Orchestrator restores both the app version and the infra config.

Grafana cools off. The service stabilizes. Coffee resumes.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec-tf-modules)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->