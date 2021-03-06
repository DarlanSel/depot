require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  def new_product(image_url)
    Product.new(title: 'Title',
                description: 'Description',
                price: 1,
                image_url: image_url)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?, "empty product shouldn't be valid"
    assert product.errors[:title].any?, "empty title shouldn't be valid"
    assert product.errors[:description].any?, "empty description shouldn't be valid"
    assert product.errors[:image_url].any?, "empty image_url shouldn't be valid"
    assert product.errors[:price].any?, "empty price shouldn't be valid"
  end

  test "product price must be positive" do
    product = Product.new(title: 'Title',
                          description: 'Description',
                          image_url: 'image.png')
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?, "positive price shouldn't be invalid"
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.gif FRED.jpg FRED.png FRED.GIF FRED.JPG FRED.PNG FRED.Gif FRED.Jpg FRED.Png http://a.b.c/x/y/z/fred.gif}

    bad = %w{fred.doc fred.gif/more fred.gif.more}

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title:        products(:ruby).title,
                          description:  'yyy',
                          price: 1,
                          image_url: 'fred.gif')

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
