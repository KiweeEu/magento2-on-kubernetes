Feature: Checkout

  Scenario: Checkout
    When I go to a product page
    And I add the product to cart
    And I go through the checkout
    Then I should see the order success page