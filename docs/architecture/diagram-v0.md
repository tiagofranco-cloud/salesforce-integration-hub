# Architecture Diagram (v0)

## High-level flow (Event + Attempt model)

[External System]
    |
    | 1) Inbound webhook (HTTP POST)
    v
[Apex REST Webhook Endpoint]
    |
    | 2) Upsert Integration_Event__c (RECEIVED)
    |    - correlationId
    |    - externalEventId (idempotency key)
    |
    | 3) Create Integration_Attempt__c (#1)
    |    - direction, httpStatus, duration, error (if any)
    |
    | 4) Enqueue async job
    v
[Queueable / Async Processor]
    |
    | 5) Validate + Transform + Persist domain data
    | 6) Create Integration_Attempt__c (retry attempts as needed)
    | 7) Update Integration_Event__c (SUCCESS / FAILED / DEAD_LETTER)
    v
[Salesforce Data Model (Custom Objects)]

## Outbound sync (future step)

[Salesforce Change/Event]
    |
    | 1) Schedule/Trigger outbound sync
    v
[Outbound Sync Service (Apex)]
    |
    | 2) Call external API via Named Credential (OAuth)
    | 3) Create Integration_Attempt__c for each call
    | 4) Update Integration_Event__c consolidated status
    v
[External System]

## Operations

[LWC Dashboard]
    |
    | View: events, attempts, failure rate, retries, dead letters
    | Action: reprocess failed/dead-letter events (future)
    v
[Integration_Event__c + Integration_Attempt__c]