# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Brand.destroy_all
User.destroy_all
Shade.destroy_all

User.create! [{username:"administrator", email: "castengo23@gmail.com", password: "ravilet7"}, {username:"gibby", email: "gibbs@doggyland.com", password: "password1"}]

administrator = User.find_by(username: "administrator").account;
administrator.create_profile!
administrator.profile.looks.create!(name: "My Look", image_url: "https://www.instagram.com/p/BMRqQ4aBJwI/?taken-by=anastasiabeverlyhills")
administrator.profile.looks.create!(name: "Another Look", image_url: "https://www.instagram.com/p/BMQQukQBqDd/?taken-by=anastasiabeverlyhills")


iggy = User.find_by(username: "gibby").account;
iggy.create_profile!
iggy.profile.looks.create!(name: "Me", image_url: "https://www.instagram.com/p/BMQGdgghTZF/?taken-by=anastasiabeverlyhills")
iggy.profile.looks.create!(name: "Another Me", image_url: "https://www.instagram.com/p/BMPxZe1BV-X/?taken-by=anastasiabeverlyhills")


Brand.create! [ {name: "Anastasia Beverly Hills", website_url:"http://www.anastasiabeverlyhills.com/", logo_url: "http://www.anastasiabeverlyhills.com/media/wysiwyg/magenthemes/mtghost/logo/abh-logo-black_3.png"}, {name: "Sephora", website_url: "http://www.sephora.com/", logo_url: "http://www.sephora.com/images/logo.svg"}, {name:"tarte",website_url:"http://tartecosmetics.com/", logo_url:"http://tarte-cdn2.s3.amazonaws.com/images/ninja/logo-new.png"}, {name:"Kylie Cosmetics", logo_url:"https://cdn.shopify.com/s/files/1/1133/5964/t/20/assets/logo.png?3306860011959784713",website_url:"https://www.kyliecosmetics.com/products/the-bronze-palette"}
]

anastasia = Brand.find_by(:name=>"Anastasia Beverly Hills")
anastasia.products.create! [ {name:"Eye Shadow Singles", photo_url:"http://www.anastasiabeverlyhills.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/p/i/pink-champagne-eye-shadow-a_1.jpg", price: 12, product_type:"Eye Shadow Single", no_of_shades: 5}, {name:"Waterproof Creme Color", photo_url: "http://www.anastasiabeverlyhills.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/j/e/jet-waterproof-creme-eyeshadow_1.jpg", price: 18, product_type:"Eye Shadow Single", no_of_shades: 5}, {name:"Modern Renaissance Palette", description:"An essential eye shadow collection featuring 14 shades, including neutral and berry tones. Use Anastasia Beverly Hills first permanent palette, Modern Renaissance to create endless looks for daytime and evening.", no_of_shades:14, photo_url:"http://www.anastasiabeverlyhills.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/m/o/modern-renaissance-eye-shadoe-palette.jpg", direct_link:"http://www.anastasiabeverlyhills.com/best-sellers/modern-renaissance-palette.html", application:"Powder", price:42, product_type:"Eye Shadow Palette"}
]

mr_palette = Product.find_by(:name => "Modern Renaissance Palette")
shades = [{name:"Tempera", hex_color:"F5D2C3", finish:"Matte"}, {name:"Golden Ochre", hex_color:"E7B284", finish:"Matte"}, {name:"Vermeer", hex_color:"E7C9C0", finish:"Matte"}, {name:"Buon Fresco", hex_color:"CA9095", finish:"Matte"}, {name:"Antique Bronze", hex_color:"AE5F55", finish:"Metallic"}, {name:"Love Letter", hex_color:"A4174F", finish:"Matte"}, {name:"Cyprus Umber",hex_color:"623831",finish:"Matte"},{name:"Raw Sienna",hex_color:"D07648",finish:"Matte"},{name:"Burnt Orange",hex_color:"e27d53", finish:"Matte"}, {name:"Primavera",hex_color:"ecb592", finish:"Metallic"},{name:"Red Ochre",hex_color:"9e3c39",finish:"Matte"},{name:"Venetian Red",hex_color:"a81d42",finish:"Metallic"}, {name:"Warm Taupe", hex_color:"c4856c",finish:"Matte"},{name:"Realgar",hex_color:"c24732",finish:"Matte"}]

shades.each do |shade|
	save_shade = mr_palette.shades.new(shade)
	# color = Color.new(:hex=>shade[:hex_color])
	# color.shades << save_shade
	save_shade.save
	# color.save
end

tarte = Brand.find_by(name:"tarte")
tarte.products.create! [ {name:"tartelette in bloom clay palette", description:"Introducing our tartelette 2 in bloom palette – featuring 12 brand new, never-before-seen shades. With 9 mattes and 3 lusters, these lid liner and crease pairings allow you to create stunning, smoldering looks without the guesswork.", no_of_shades:12, photo_url:"http://tarte-cdn2.s3.amazonaws.com/item/full/712.jpg", direct_link:"http://tartecosmetics.com/tarte-item-tartelette-in-bloom", application:"Powder", price:45, product_type:"Eye Shadow Palette"}]

tarte_palette = Product.find_by(name:"tartelette in bloom clay palette")
shades2 = [{name:"Charmer", hex_color:"F5D6CD", finish:"Matte"}, {name:"Jetsetter",hex_color:"C68E75",finish:"Matte"}, {name:"Rocker", hex_color:"CA9183",finish:"Metallic"},{name:"Smokeshow",hex_color:"302420",finish:"Matte"}, {name:"Flower Child",hex_color:"EABCA6",finish:"Matte"},{name:"Smarty Pants",hex_color:"E09979",finish:"Matte"}, {name:"Firecracker",hex_color:"B36C55",finish:"Metallic"}, {name:"Activist",hex_color:"442A22",finish:"Matte"},{name:"Funny Girl", hex_color:"E6B29E", finish:"Metallic"},{name:"Sweetheart", hex_color:"D59887",finish:"Matte"},{name:"Rebel",hex_color:"904737", finish:"Matte"},{name:"Leader", hex_color:"5E302A",finish:"Matte"}]

shades2.each do |shade|
	save_shade = tarte_palette.shades.new(shade)
	# color = Color.new(:hex=>shade[:hex_color])
	# color.shades << save_shade
	save_shade.save
	# color.save
end

kyliecosmetics = Brand.find_by(name:"Kylie Cosmetics")
kyliecosmetics.products.create! [{name:"The Bronze Palette", description:"The #KylieCosmetics Kyshadow pressed powder eye shadow palette is your secret weapon to create the perfect Kylie eye. Each Kyshadow Kit comes with 9 pressed powder eye shadows that can be used together to recreate Kylie’s favorite looks or customize your own.", product_type:"Eye Shadow Palette", no_of_shades:9, photo_url:"https://cdn.shopify.com/s/files/1/1133/5964/products/kc-kyshadow-productphoto-3.jpg?v=1469639800",direct_link:"https://www.kyliecosmetics.com/products/the-bronze-palette",application:"Powder"}
]

kylie_bronze = Product.find_by(name: "The Bronze Palette")

shades3 = [{name:"Jasper", hex_color:"f1ccac", finish:"Matte"},{name:"Quartz", finish:"Satin", hex_color:"d99a6a"},{name:"Topaz", finish:"Matte", hex_color:"ab6336"},{name:"Goldstone", finish:"Satin", hex_color:"a46133"},{name:"Citrine",finish:"Matte",hex_color:"de671d"},{name:"Tiger Eye", finish:"Matte",hex_color:"b24f15"},{name:"Hematite",finish:"Matte", hex_color:"a8431c"},{name:"Bronze",finish:"Matte",hex_color:"4e2111"},{name:"Onyx", finish:"Matte", hex_color:"21160b"}]

shades3.each do |shade|
	save_shade = kylie_bronze.shades.new(shade)
	# color = Color.new(:hex=>shade[:hex_color])
	# color.shades << save_shade
	save_shade.save
	# color.save
end

administrator.profile.looks.first.tutorials.create!(shade_id: Shade.first.id)
