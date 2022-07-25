Feature:Exploring the Amazon
Background:
Given I import scenarios from "Test Cases\Web exercises testing\Utilities\Amazon_utility"
Given I assign "chrome" to variable "browser"
Then I assign "http://www.google.com" to variable "dstWebsite"
And I assign "https://www.amazon.in/" to variable "searchPhrase"

After Scenario:
Given I close web browser

Scenario: Amazon
Given I execute scenario "Browser Verification"
And I execute scenario "Return To Amazon HomePage"
And I execute scenario "Search"
Then I execute scenario "Return To Amazon HomePage"
And I execute scenario "Navigate To Best Sellers"
Then I execute scenario "Return To Amazon HomePage"
Then I execute scenario "Prime Video"
