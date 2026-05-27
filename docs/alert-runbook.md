# Alert Runbook

This document covers every alert this Terraform config can generate — what it means, why it fired, and what to do.

---

## P1 – AVAILABILITY

### Service Unavailable
**What it means:** Dynatrace has lost contact with the service entirely or all requests are failing.  
**First check:** ECS task health in AWS console — are tasks in RUNNING state?  
**Common causes:** ECS task crash loop, OOM kill, failed deployment  
**Action:**
1. `aws ecs describe-services --cluster <name> --services <service>` — check runningCount vs desiredCount
2. Check CloudWatch logs: `/ecs/<service-name>` — look for OOM or startup errors
3. If deployment in progress: `aws ecs rollback` or redeploy previous task definition revision

---

## P1 – ERROR

### Error Rate Elevated (above threshold)
**What it means:** Request error rate crossed the per-service threshold defined in `terraform.tfvars`.  
**Threshold:** Different per service — check `services.<name>.error_rate_threshold_percent` in tfvars.  
**First check:** Is this a new deployment? Check ECS deployment timestamps.  
**Common causes:** Upstream API down, database connection exhausted, new code bug  
**Action:**
1. Check error samples in Dynatrace: service → Multidimensional analysis → filter by error
2. Check RDS connection count in CloudWatch: `DatabaseConnections` metric
3. Check upstream dependency health in Dynatrace service flow

---

## P2 – PERFORMANCE

### P95 Response Time Degraded
**What it means:** 95th percentile response time exceeded threshold for 3 consecutive minutes.  
**Note:** Not all requests are slow — P95 means the slowest 5% are impacted.  
**Common causes:** Cold start after scale-out event, database slow query, memory pressure  
**Action:**
1. Check Dynatrace hot spots: service → Method hotspots — find the slow method
2. Check ECS CPU/memory in CloudWatch — is the task under memory pressure?
3. Check RDS slow query log if database queries are in the hot spots
4. Check if a new ECS task just launched — cold starts can temporarily spike P95

### Resource Contention
**What it means:** CPU or memory contention detected on the underlying container.  
**Action:**
1. ECS console → check CPU/memory utilization metrics for the task
2. If consistently high: update task definition with higher `cpu`/`memory` values
3. If spikey: check if Auto Scaling is triggering — may be a brief burst before scale-out

---

## P3 – MONITORING UNAVAILABLE

### OneAgent disconnected
**What it means:** Dynatrace OneAgent sidecar lost connection to the tenant.  
**Not urgent** — service is still running, just unmonitored.  
**Action (next business day):**
1. Check ECS task is running the OneAgent sidecar container
2. Check outbound network connectivity from ECS task to `*.live.dynatrace.com:443`
3. Check security group on ECS tasks — port 443 outbound required

---

## Maintenance window behavior

When a maintenance window is active (during deployments), **all alerts are suppressed** for the configured duration.

To manually activate a maintenance window outside of the automated deployment flow:

```bash
curl -s -X POST \
  -H "Authorization: Api-Token $DT_API_TOKEN" \
  -H "Content-Type: application/json" \
  "${DT_ENV_URL}/api/config/v1/maintenanceWindows/<window-id>/activate"
```

Get the window ID from Terraform output: `terraform output maintenance_window_id`
