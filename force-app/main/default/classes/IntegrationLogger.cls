public with sharing class IntegrationLogger {
    public class EventInfo {
        public String correlationId;
        public String externalEventId;
        public String sourceSystem;
        public String eventType;
        public String status; // RECEIVED, PROCESSING, SUCCESS, FAILED, DEAD_LETTER
    }

    public class AttemptInfo {
        public Integer attemptNumber;
        public String direction; // INBOUND, OUTBOUND
        public Integer httpStatus;
        public Long durationMs;
        public String errorMessage;
    }

    /**
     * Upsert (or create) Integration_Event__c using External_Event_Id__c as the idempotency key.
     * NOTE: We are not marking External_Event_Id__c as External ID yet; we do a query+upsert pattern.
     */
    public static Integration_Event__c upsertEvent(EventInfo info) {
        if (info == null) {
            throw new IllegalArgumentException('EventInfo is required');
        }
        if (String.isBlank(info.externalEventId)) {
            throw new IllegalArgumentException('externalEventId is required');
        }

        Integration_Event__c evt;
        List<Integration_Event__c> existing = [
            SELECT Id, Status__c
            FROM Integration_Event__c
            WHERE External_Event_Id__c = :info.externalEventId
            LIMIT 1
        ];

        if (!existing.isEmpty()) {
            evt = existing[0];
        } else {
            evt = new Integration_Event__c();
            evt.External_Event_Id__c = info.externalEventId;
        }

        if (!String.isBlank(info.correlationId)) evt.Correlation_Id__c = info.correlationId;
        if (!String.isBlank(info.sourceSystem)) evt.Source_System__c = info.sourceSystem;
        if (!String.isBlank(info.eventType)) evt.Event_Type__c = info.eventType;
        if (!String.isBlank(info.status)) evt.Status__c = info.status;

        upsert evt;
        return evt;
    }

    /**
     * Create a new Integration_Attempt__c linked to an Integration_Event__c.
     */
    public static Integration_Attempt__c createAttempt(Id eventId, AttemptInfo info) {
        if (eventId == null) {
            throw new IllegalArgumentException('eventId is required');
        }
        if (info == null) {
            throw new IllegalArgumentException('AttemptInfo is required');
        }

        Integration_Attempt__c att = new Integration_Attempt__c();
        att.Integration_Event__c = eventId;

        if (info.attemptNumber != null) att.Attempt_Number__c = info.attemptNumber;
        if (!String.isBlank(info.direction)) att.Direction__c = info.direction;
        if (info.httpStatus != null) att.Http_Status__c = info.httpStatus;
        if (info.durationMs != null) att.Duration_Ms__c = info.durationMs;
        if (!String.isBlank(info.errorMessage)) att.Error_Message__c = info.errorMessage;

        insert att;
        return att;
    }

    /**
     * Convenience helper to update consolidated event status.
     */
    public static void updateEventStatus(Id eventId, String status) {
        if (eventId == null) return;
        if (String.isBlank(status)) return;

        update new Integration_Event__c(
            Id = eventId,
            Status__c = status
        );
    }
}