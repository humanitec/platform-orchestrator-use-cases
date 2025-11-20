# Updating environments without breaking anything (rollout management)

The Platform Orchestrator can rollout infrastructure updates across your estate in controlled waves, providing full rollout control and progress visibilty.

> ℹ️ **Note**
> 
> The use case implementation on Terraform/OpenTofu is currently being prepared. We are publishing the use case description ahead of time to illustrate the Orchestrator capabilities to interested users.

## Scenario

Thursday rolls in with something shiny:

A new major version of the Postgres operator drops, promising better performance and nicer autoscaling behavior. Alex the platform engineer wants to try it out, but no way this thing touches production without guardrails.

This is the perfect moment for a controlled rollout.

Alex heads into the Orchestrator and creates an updated version of the Postgres module that uses the new operator. Instead of deploying it everywhere blindly, Alex sets a clear, staged rollout plan inside the Orchestrator:

1. Update all ephemeral environments first
2. Then dev
3. Then staging
4. And only if all goes well, production

Alex triggers wave 1, updating only the ephemeral environments. As soon as those updates are underway, Alex switches to Grafana to check how the ephemeral environments respond:

- Are latency and error rates normal?
- Are there connection spikes or weird restarts?
- Any signs the new operator version changed behavior?

If Grafana shows issues in the ephemeral environments, Alex can immediately switch back to the Orchestrator and:

- Roll back the module version *just for ephemerals*
- Patch the module
- Re-run wave 1 safely

If Grafana looks healthy, Alex proceeds to wave 2, updating the dev environments next. Wave by wave, Alex keeps flipping between:

- The Orchestrator to execute the rollout
- Grafana to observe the impact

This gives Alex total control with minimal blast radius.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec-tf-modules)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->