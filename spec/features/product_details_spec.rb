require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel4.jpg'),
        quantity: 5,
        price: 25
      )
    end
  end

  scenario "Product Details" do
    # ACT
    visit root_path

    click_link(@category.products.first.name)
   
    #DEBUG
    puts page.html
    save_screenshot

    # VERIFY

    expect(page).to have_current_path("/products/1")

  end


end
