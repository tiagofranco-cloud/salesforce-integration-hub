# ADR-002 — Separate Integration Event and Attempt objects

## Context
The integration logging system must support retries, observability and enterprise-grade monitoring.

Initial design considered a single Integration_Log object.

## Decision
Split logging into two objects:

- Integration_Event__c (one per external event)
- Integration_Attempt__c (one per processing attempt)

With master-detail relationship:
Integration_Event__c → Integration_Attempt__c

## Rationale
This allows:
- multiple retries per event
- accurate metrics (attempt count, success rate)
- detailed failure tracking
- future reprocessing
- scalable observability patterns

Aligns with enterprise messaging patterns (Kafka, queues, DLQ).

## Alternatives considered
Single log table (rejected: limited observability and retry tracking)

## Status
Accepted