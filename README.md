# Salesforce Integration Hub

Enterprise-grade integration logging framework built with Salesforce Apex and Custom Objects.

This project implements a structured observability pattern for inbound and outbound integrations inside Salesforce.

---

## 🎯 Objective

Provide a scalable and idempotent logging architecture to:

- Track external events
- Prevent duplicate processing
- Log retry attempts
- Measure HTTP status and latency
- Enable future retry orchestration
- Support enterprise-grade integration monitoring

---

## 🏗 Architecture Overview

### Core Objects

**Integration_Event__c**
- Correlation_Id__c
- External_Event_Id__c
- Source_System__c
- Event_Type__c
- Status__c

Represents the consolidated business event.

**Integration_Attempt__c**
- Attempt_Number__c
- Direction__c (INBOUND | OUTBOUND)
- Http_Status__c
- Duration_Ms__c
- Error_Message__c
- Master-Detail → Integration_Event__c

Represents each processing attempt.

---

## 🧠 Service Layer

`IntegrationLogger.cls`

Provides:

- Idempotent event upsert
- Attempt creation
- Event status updates

Designed following service-layer and observability patterns.

---

## 🧪 Testing

`IntegrationLoggerTest.cls`

- Covers event creation
- Covers attempt creation
- Covers status updates
- 100% pass rate in Developer Org

---

## 🚀 Next Steps

- Add retry orchestration via Queueable Apex
- Implement HTTP callout service
- Introduce circuit breaker pattern
- Create LWC dashboard for monitoring
- Enable External ID for idempotency optimization

---

## 📌 Tech Stack

- Salesforce DX
- Apex
- Custom Objects (Metadata API)
- SOQL
- CLI-based deployment
- Git version control

---

## 👤 Author

Tiago Franco  
Cloud / DevOps Engineer → Salesforce Integration Architect (in progress)