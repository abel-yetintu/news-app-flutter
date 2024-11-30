Feature: Top headlines feature

    Background:
        Given the app is running

    Scenario: Display article tiles in top headlines screen
        Then i should see a list of articles

    Scenario: Display error tiles in top headlines screen
        Then i should see a list of error tiles