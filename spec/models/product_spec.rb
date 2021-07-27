require 'rails_helper'


RSpec.describe Product, type: :model do


    subject { Product.new(
                  name: "Lamp",
                  price_cents: 500,
                  quantity: 4,
                  category: "Home Decor"
              )}

  it "is valid with all fields" do
    expect(subject).to be_valid
  end

  describe 'Validations' do
    it "is not valid without a valid name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a valid price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end

    it "is valid with a valid quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "is valid with a valid category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end

  end
end