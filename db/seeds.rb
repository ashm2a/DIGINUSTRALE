# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
Porc.destroy_all
User.destroy_all
Abattage.destroy_all

puts "crzxeating user"
user = User.create!(
  nom: "Santoni", prénom: "Paul-François", EDE: "02AANE" , email: "santoni.audrey@gmail.com", password: "123456", adresse: "53 route de curratoghja", code_postal: 20113, ville: "Olmeto"
)

puts "creating porc abattage"

porc_abattage = Abattage.create!(numéro_lot: 1, date: Date.new(2022, 11, 30), lieu: "Ponte Leccia")

puts "Creating porcs..."
porc_one = { user: user, boucle: "00011", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2019, 11, 10), sexe: "femelle", abattage: porc_abattage }
porc_two = { user: user, boucle: "00007", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2019, 12, 10), sexe: "mâle" }
porc_three = { user: user, boucle: "00006", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2019, 12, 10), sexe: "femelle" }
porc_four = { user: user, boucle: "00010", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2019, 11, 10), sexe: "mâle", abattage: porc_abattage }
porc_five = { user: user, boucle: "00012", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2020, 12, 10), sexe: "femelle"}
porc_six = { user: user, boucle: "00013", boucle_mère: "00011", boucle_père: "00007", date_de_naissance: Date.new(2021, 11, 11), sexe: "femelle", abattage: porc_abattage }

[porc_one, porc_two, porc_three, porc_four, porc_five, porc_six].each do |attributes|
  Porc.create!(attributes)
  puts "Created porcs"
end
puts "Finished!"
