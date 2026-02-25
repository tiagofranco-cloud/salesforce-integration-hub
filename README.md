# Salesforce Integration Hub

Enterprise-grade Salesforce integration architecture with APIs, webhooks, async processing, retries and observability.

## What this project demonstrates
This repository is a hands-on reference implementation of common integration patterns used in enterprise Salesforce projects:

- Inbound webhooks (Apex REST) with **idempotency**
- Async processing (Queueable/Batch) with **retry** and **dead-letter**
- Outbound sync (Salesforce → external API) with resiliency
- **Named Credentials / OAuth** best practices
- **Observability**: correlationId, structured logs, reprocessing flows
- Salesforce DX workflow (source-driven development)

## Architecture (high level)
> Diagram will be added in `docs/architecture/`.

**Flows**
1. **Inbound**: External System → Webhook (Apex REST) → Queue → Persist → Integration Log  
2. **Outbound**: Salesforce Change → Sync Job → External API → Retry/Dead-letter → Integration Log  
3. **Ops**: LWC Dashboard → View status → Reprocess failed messages

## Tech stack
- Salesforce: Apex, SOQL, Async Apex, LWC
- Integration: REST, Webhooks, OAuth (Named Credentials)
- Tooling: Salesforce CLI (sf), VS Code, Git

## Repository structure
- `force-app/` — Salesforce source (Apex/LWC/metadata)
- `docs/architecture/` — diagrams and technical notes
- `docs/adr/` — Architecture Decision Records (ADRs)
- `scripts/` — helper scripts (deploy, test, etc.)

## Roadmap (MVP)
- [ ] Create Salesforce DX project structure under `force-app/`
- [ ] Define objects: `Integration_Log__c` (and supporting fields)
- [ ] Implement inbound webhook (Apex REST) + idempotency key
- [ ] Implement async pipeline (Queueable) + retry + dead-letter
- [ ] Implement outbound sync service + Named Credential
- [ ] Create LWC dashboard for logs and reprocessing
- [ ] Add architecture diagram and ADRs
- [ ] Add CI workflow (basic: run tests)

## Notes
This project is built as a portfolio piece focusing on **integration/architecture** patterns — the same topics that appear in high-ticket Salesforce engagements.