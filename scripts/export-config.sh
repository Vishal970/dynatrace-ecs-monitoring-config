#!/usr/bin/env bash
# Export existing Dynatrace config before migrating to Terraform
# Usage: ./scripts/export-config.sh ./exported-config
set -euo pipefail

OUTPUT_DIR=${1:-./exported-config}
mkdir -p "${OUTPUT_DIR}"

: "${DT_ENV_URL:?Must set DT_ENV_URL}"
: "${DT_API_TOKEN:?Must set DT_API_TOKEN}"

echo "Exporting Dynatrace config from: ${DT_ENV_URL}"

# Export management zones
echo "  → Management zones..."
curl -s -H "Authorization: Api-Token ${DT_API_TOKEN}" \
  "${DT_ENV_URL}/api/config/v1/managementZones" \
  | jq '.' > "${OUTPUT_DIR}/management-zones.json"

# Export alerting profiles
echo "  → Alerting profiles..."
curl -s -H "Authorization: Api-Token ${DT_API_TOKEN}" \
  "${DT_ENV_URL}/api/config/v1/alertingProfiles" \
  | jq '.' > "${OUTPUT_DIR}/alerting-profiles.json"

# Export auto-tagging rules
echo "  → Auto-tagging rules..."
curl -s -H "Authorization: Api-Token ${DT_API_TOKEN}" \
  "${DT_ENV_URL}/api/config/v1/autoTags" \
  | jq '.' > "${OUTPUT_DIR}/auto-tagging.json"

# Export notification configurations
echo "  → Notifications..."
curl -s -H "Authorization: Api-Token ${DT_API_TOKEN}" \
  "${DT_ENV_URL}/api/config/v1/notifications" \
  | jq '.' > "${OUTPUT_DIR}/notifications.json"

# Export metric events
echo "  → Metric events (custom anomaly detection)..."
curl -s -H "Authorization: Api-Token ${DT_API_TOKEN}" \
  "${DT_ENV_URL}/api/v2/settings/objects?schemaIds=builtin:anomaly-detection.metric-events&pageSize=100" \
  | jq '.' > "${OUTPUT_DIR}/metric-events.json"

echo ""
echo "Export complete: ${OUTPUT_DIR}"
echo "Zone IDs for import:"
jq -r '.values[] | "  terraform import dynatrace_management_zone_v2.<name> \(.id)"' \
  "${OUTPUT_DIR}/management-zones.json"
