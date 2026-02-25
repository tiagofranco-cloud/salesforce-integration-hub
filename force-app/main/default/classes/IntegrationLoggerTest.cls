@isTest
private class IntegrationLoggerTest {

    @isTest
    static void testCreateEventAndAttempt() {

        // cria dados fake
        IntegrationLogger.EventInfo evtInfo = new IntegrationLogger.EventInfo();
        evtInfo.externalEventId = 'evt-test-001';
        evtInfo.correlationId = 'corr-001';
        evtInfo.sourceSystem = 'SHOPIFY';
        evtInfo.eventType = 'ORDER_CREATED';
        evtInfo.status = 'RECEIVED';

        // cria evento
        Integration_Event__c evt = IntegrationLogger.upsertEvent(evtInfo);

        System.assertNotEquals(null, evt.Id, 'Event should be created');

        // cria tentativa
        IntegrationLogger.AttemptInfo attInfo = new IntegrationLogger.AttemptInfo();
        attInfo.attemptNumber = 1;
        attInfo.direction = 'INBOUND';
        attInfo.httpStatus = 200;
        attInfo.durationMs = 120;
        attInfo.errorMessage = null;

        Integration_Attempt__c att =
            IntegrationLogger.createAttempt(evt.Id, attInfo);

        System.assertNotEquals(null, att.Id, 'Attempt should be created');

        // atualiza status final
        IntegrationLogger.updateEventStatus(evt.Id, 'SUCCESS');

        Integration_Event__c updated =
            [SELECT Status__c FROM Integration_Event__c WHERE Id = :evt.Id];

        System.assertEquals('SUCCESS', updated.Status__c);
    }
}