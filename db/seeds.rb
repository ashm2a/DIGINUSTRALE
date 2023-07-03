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

puts "creating user"
user = User.create!(
  nom: "Santoni",
  prénom: "Paul-François",
  EDE: "02AANE" ,
  email: "santoni.audrey@gmail.com",
  password: "123456",
  adresse: "53 route de curratoghja",
  code_postal: 20113,
  ville: "Olmeto"
)

puts "Creating porcs..."
porc_one = {
  user: user,
  boucle: "00006",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2020, 07, 28),
  sexe: "femelle"
}
porc_two = {
  user: user,
  boucle: "00007",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2020, 07, 28),
  sexe: "mâle"
}
porc_three = {
  user: user,
  boucle: "00008",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2020, 07, 28),
  sexe: "femelle" }
porc_four = {
  user: user,
  boucle: "00009",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2021, 01, 10),
  sexe: "mâle"
}
porc_five = {
  user: user,
  boucle: "00010",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2021, 01, 10),
  sexe: "femelle"
}
porc_six = {
  user: user,
  boucle: "00011",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2021, 01, 10),
  sexe: "mâle"
}
porc_seven = {
  user: user,
  boucle: "00012",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2021, 01, 10),
  sexe: "mâle"
}
porc_eight = {
  user: user,
  boucle: "00013",
  boucle_mère: "00001",
  boucle_père: "00002",
  date_de_naissance: Date.new(2021, 01, 10),
  sexe: "femelle"
}

[porc_one, porc_two, porc_three, porc_four, porc_five, porc_six, porc_seven, porc_five, porc_six, porc_seven, porc_eight].each do |attributes|
  Porc.create!(attributes)
  puts "Created porcs"
end

puts "Finished!"
