Feature:
  
  As a inspirational author of my blog
  In order to incorporate my critical thinking abilities
  I want to be able to merge my articles
 
Background:
  
  Given the blog is set up
  
  Given the following articles exist:
  |id | title    | author | user_id | body     | allow_comments |
  |1  | Madagas  | JK     | 1       | One      | true           |
  |2  | Truly    | Minnie | 2       | Two      | true           |
  
  Given the following comments exist:
  |id | type    | author | body     | article_id | user_id |
  |1  | Comment | Ross   | Up       | 1          | 2       |
  |2  | Comment | Tros   | Down     | 2          | 2       |
  
  Given the following users exist:
  | profile_id | login  | name  | password | email           | state  |
  | 2          | JK     | JK    | qwerty   | 1@gmail.com     | active |
  | 3          | Minnie | Minnie| qwerty   | 2@gmail.com     | active |
 
Scenario: A non-admin cannot merge two articles
  Given I log in using username "JK" with password "qwerty"
  And I am on Edit page of Article with id 1
  Then I should not see "Merge Article"

Scenario: Merge articles as admin
  Given I log in using username "admin" with password "uiop"
  And I am on the Edit Page of Article with id 1
  Then I should see "Merge Articles"
  When I fill in "merge_id" with "2"
  And I press "Merge"
  Then I should be on the admin content page
  And I should see "Merge Articles Success"

Scenario: Merged articles contained body of its ingredients
  Given articles with id "1" and "2" are merged
  And I am on the home page
  When I follow "Madagas"
  Then I should see "One"
  Then I should see "Two"

Scenario: merged articles contained either one of ingredients authors
  Given articles with id "1" and "2" are merged
  Then author "JK" should have 1 article
  Then author "Minnie" should have 0 article

Scenario: Merged articles contained comments of its ingredients
  Given articles with id "1" and "2" are merged
  And I am on the home page
  When I follow "Madagas"
  Then I should see "Up"
  Then I should see "Down"

Scenario: merged articles contained either one of ingredients title
  Given articles with id "1" and "2" are merged
  And I am on the home page
  Then I should see "Madagas"
  Then I should not see "Truly"
  
  
  