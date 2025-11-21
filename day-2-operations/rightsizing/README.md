# Rightsizing for cost control

The Platform Orchestrator can assist in rightsizing infrastructure resources by applying more cost efficient configurations.

> ℹ️ **Note**
> 
> The use case implementation on Terraform/OpenTofu is currently being prepared. We are publishing the use case description ahead of time to illustrate the Orchestrator capabilities to interested users.

## Scenario: why is this database so damn big?

Friday mornings are supposed to be quiet. Alex the platform engineer opens Grafana to check the weekly cost and utilization dashboards before diving into code reviews.

One widget sticks out immediately:

**"Top 10 Most Expensive Resources Across Production"**

And sitting comfortably at number 2 is the `orders-db` instance, a Postgres database supporting a backend service that hasn’t seen major traffic since Black Friday seven months ago.

But the Grafana throughput graph tells the real story:

- CPU: flatlining at 3 to 5 percent
- IOPS: basically a heartbeat pattern
- Storage: 60 percent allocated, but only 25 percent actually used
- Query latency: stable, no signs of stress

Alex squints at it thinking: "Why is this thing an XXL box? Did someone size this for the apocalypse?"

He reaches out to the application team maintaining the backend service via chat and explains his findings, suggesting a different size class for this database. The app team agree to discuss the idea internally. They get back to Alex a day later, confirming they have adjusted the "size class" from "XXL" to "L" in their database resource request and are now progressing normally through their deployment cadence, using the Platform Orchestrator to rollout the change through their environments.

Just another day later, the change arrives on production and the Orchestrator adjusts the Postgres size. Alex and the app team give thumbs up to each other on the chat, and another resource now makes the "Most expensive" top 10 list.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec-tf-modules)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->