# Changelog

## [1.2.1] - 2025-04-03
### Fixed
- Management zone scope was matching ALL environments when `env` tag was absent — added `NOT_EXISTS` fallback condition to prevent cross-environment bleed
- Alerting profile P3 time filter had timezone hardcoded to UTC — parameterized to `var.timezone` so teams in different regions can configure correctly

## [1.2.0] - 2025-02-18
### Added
- Maintenance window resource — suppresses Dynatrace alerts during scheduled deployments
- `scripts/export-config.sh` — exports existing tenant config to JSON before migration
- Davis AI problem suppression set to 72h for new deployments (configurable via `var.new_service_suppression_hours`)

### Changed
- Split PagerDuty integration into separate `notifications` submodule — cleaner dependency graph
- Dev environment now disables PagerDuty entirely; was previously duplicating prod behavior and paging during dev incident testing

## [1.1.0] - 2024-12-05
### Added
- Custom metric events for per-service response time thresholds — replaces Dynatrace automatic baseline for high-variance services
- Auto-tagging rules pulling `app`, `env`, `team`, `version` from ECS task definition labels
- Slack notification integration with separate webhooks per severity tier

### Changed
- Alerting profiles restructured from 2 tiers (critical/warning) to 3 tiers (P1/P2/P3) — P3 added for non-urgent infrastructure drift
- P1 delay reduced from 5 minutes to 0 minutes — immediate paging for production critical issues

### Fixed
- Auto-tagging rule was matching process groups instead of services — corrected entity selector to `SERVICE` type

## [1.0.0] - 2024-10-14
### Added
- Initial release — management zones, alerting profiles, basic auto-tagging
- Dev and prod environment configs
- GitHub Actions CI for fmt, validate
- Separate PagerDuty + Slack notification resources per environment
