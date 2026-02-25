# Architecture Diagram (v0)

## High-level flow

[External System]
    |
    | 1) Inbound webhook (HTTP POST)
    v
[Apex REST Webhook Endpoint]
    |
    | 2) Create/Update Integration_Log__c (RECEIVED)
    | 3) Enqueue async job
    v
[Queueable / Async Processor]
    |
    | 4) Validate + Transform + Persist domain data
    | 5) Update Integration_Log__c (SUCCESS / FAILED / RETRYING / DEAD_LETTER)
    v
[Salesforce Data Model (Custom Objects)]

## Outbound sync (future step)

[Salesforce Change/Event]
    |
    | 1) Schedule/Trigger sync
    v
[Outbound Sync Service (Apex)]
    |
    | 2) Call external API via Named Credential (OAuth)
    | 3) Update Integration_Log__c with httpStatus + timing
    v
[External System]

## Operations

[LWC Dashboard]
    |
    | View: status, counts, recent failures
    | Action: reprocess failed logs (future)
    v
[Integration_Log__c]