require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      @a_product = Product.new(name: "Jeans", price_cents: 2000, quantity: 10)
      @category = Category.new(name: "Clothes")
      @a_product.category = @category
    end

    it "is valid with all valid fields" do
      expect(@a_product).to be_valid
    end

    it "is not valid if name is not valid" do
      @a_product.name = nil
      expect(@a_product).to_not be_valid
    end

    it "is not valid if price is not valid" do
      @a_product.price_cents = nil
      expect(@a_product).to_not be_valid
    end

    it "is not valid if quantity is not valid" do
      @a_product.quantity = nil
      expect(@a_product).to_not be_valid
    end

    it "is not valid if category is not valid" do
      @a_product.category = nil
      expect(@a_product).to_not be_valid
    end



  end
end
