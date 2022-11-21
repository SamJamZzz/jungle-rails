require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation: ' do
    it 'a product with all 4 fields should save successfully' do
      @category = Category.create(name: "Cars")
      @product = Product.create(name: "Civic", price_cents: 12, quantity: 34, category: @category)
      expect(@product.valid?).to be true
    end

    it 'name should be nil' do
      @category = Category.create(name: "Cacti")
      expect(@category).to be_present

      @product = Product.create(name: nil, price_cents: 2500, quantity: 15, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'price should be nil' do
      @category = Category.create(name: "Cacti")
      expect(@category).to be_present

      @product = Product.create(name: 'Saguaro', price_cents: nil, quantity: 15, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it 'quantity should be nil' do
      @category = Category.create(name: "Cacti")
      expect(@category).to be_present

      @product = Product.create(name: 'Saguaro', price_cents: 2500, quantity: nil, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it 'category should be nil' do
      @category = nil
      expect(@category).to be nil

      @product = Product.create(name: nil, price_cents: 2500, quantity: 15, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:category]).to include("can't be blank")
    end
  end
end