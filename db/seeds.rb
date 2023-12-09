# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def encode_id(id)
  Base64.urlsafe_encode64(id.to_s)
end

user = User.create(email: "fede@gmail.com",
                   username: "fedeherce",
                   password: "1234")

first_link = Link.create(url: "https://www.google.com/",
                        user_id: user.id,
                        type:"RegularLink",
                        nombre: "Estadisticas pasadas")
first_link.update(short_url: "l/#{encode_id(first_link.id)}")
LinkStatistic.create(link_id: first_link.id, access_date: Date.new(2023,9,5), access_count: 1)
LinkAccessDetail.create(link_id: first_link.id, access_datetime:  DateTime.new(2023, 9, 5, 12, 0, 0), ip_address: "127.0.0.1")


second_link = Link.create(url: "https://www.info.unlp.edu.ar/",
                         user_id: user.id,
                         type:"TemporalLink",
                         nombre: "Vence en año nuevo",
                         expiration_date: "2023-12-31T23:59")
second_link.update(short_url: "l/#{encode_id(second_link.id)}")

third_link = Link.create(url: "https://www.info.unlp.edu.ar/",
                         user_id: user.id,
                         type:"TemporalLink",
                         nombre:"Link vencido",
                         expiration_date: "2023-09-05T17:00")
third_link.update(short_url: "l/#{encode_id(third_link.id)}")

fourth_link = Link.create(url: "https://catedras.linti.unlp.edu.ar/",
                         user_id: user.id,
                         type:"PrivateLink",
                         password: "1234",
                         nombre: "La contraseña es 1234")
fourth_link.update(short_url: "l/#{encode_id(fourth_link.id)}")

fifth_link = Link.create(url: "https://autogestion.guarani.unlp.edu.ar/",
                        user_id: user.id,
                        type: "EphemeralLink",
                        nombre:"Efímero sin ingresar",
                        entered: false)
fifth_link.update(short_url: "l/#{encode_id(fifth_link.id)}")
