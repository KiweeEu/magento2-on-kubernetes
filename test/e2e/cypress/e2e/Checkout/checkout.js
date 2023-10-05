import { Given, When, Then } from "cypress-cucumber-preprocessor/steps";

When('I search for {string}', (query) => {
  cy.visit(`/catalogsearch/result?q=${query}`)
})

When('I go to a product page', () => {
  cy.visit('/simple-product-1.html')
})

When('I add the product to cart', () => {
  cy.get('#product-addtocart-button')
    .click()

  cy.get('.message.success')
    .should('be.visible')
})

When('I add a product to cart', () => {
  cy.get('.action.tocart')
    .first()
    .click({force: true})
})

When('I go through the checkout', () => {
  cy.visit('/checkout')

  cy.get('#shipping').first().should('be.visible')
  cy.get('.message-error').should('not.exist')
  cy.get('#checkout-loader').should('not.exist')

  cy.get('#shipping [name=username]').type('test@example.com')
  cy.get('#shipping [name=firstname]').type('Testperson')
  cy.get('#shipping [name=lastname]').type('Test')

  cy.get('#shipping [name="street[0]"]').type('Test 1')
  cy.get('#shipping [name=city]').type('Test')
  cy.get('#shipping [name=postcode]').type('90210')

  cy.get('#shipping [name=region_id]').select('California')
  cy.get('#shipping [name=telephone]').type('000-000-000')

  cy.get('#co-shipping-method-form td.col-carrier')
    .should('exist')

  cy
    .get('#co-shipping-method-form input[type=radio]')
    .check('flatrate_flatrate')

  cy
    .get('#checkoutSteps .button.action.continue.primary')
    .first()
    .click()

  cy.get('#payment').first().should('be.visible')
  cy.get('.message-error').should('not.exist')
  cy.get('#checkout-loader').should('not.exist')

  cy
    .get('#checkoutSteps .action.checkout.primary')
    .last()
    .click()
})

Then('I should see the order success page', () => {
  cy.url()
    .should('include', '/checkout/onepage/success')
})
