Feature: Search feature

    Background:
        Given the app is running
    
    Scenario: Display articles
        And I am on the search page  
        When I enter {'search term'} into the search bar  
        And I submit the search query
        Then I should see a list of articles

    Scenario: Display error tiles
        And I am on the search page  
        When I enter {'search term'} into the search bar  
        And I submit the search query
        Then I should see a list of error tiles
