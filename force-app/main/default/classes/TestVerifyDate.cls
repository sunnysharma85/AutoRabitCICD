@isTest
private class TestVerifyDate {
	@istest
    private static void testMethodPositive() {
        VerifyDate.CheckDates(System.Today(), System.Today());
        VerifyDate.CheckDates(System.Today(), System.Today().addDays(-10));
        VerifyDate.CheckDates(System.Today(), System.Today().addDays(10));
    }
}