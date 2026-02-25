# ADR-001 — Integration log does not store full payloads

## Context
This project implements enterprise Salesforce integration patterns (webhooks, outbound sync, retries and observability).
To operate integrations reliably, we need logs that support troubleshooting, metrics and reprocessing.

## Decision
Do **not** store full request/response payloads in Salesforce.
Store only:
- correlationId
- externalEventId (idempotency key)
- status / httpStatus
- attempt count
- timing (duration)
- error details (message/code)
- payload hash (optional)

## Rationale
- Security & privacy (avoid sensitive data exposure)
- Lower storage and performance overhead
- Easier compliance (LGPD/GDPR) and governance
- Payloads can be traced via external logging systems if required

## Alternatives considered
- Store full payloads in `Integration_Log__c` (rejected due to privacy/volume)
- Store payloads in encrypted fields (still high storage and governance cost)
- Store payloads externally (accepted as future enhancement)

## Status
Accepted