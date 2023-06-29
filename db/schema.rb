# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_29_154514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abattages", force: :cascade do |t|
    t.integer "numéro_lot"
    t.date "date"
    t.string "lieu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coppas", force: :cascade do |t|
    t.bigint "porc_id", null: false
    t.integer "numéro_lot"
    t.float "poids"
    t.float "epaisseur_lard"
    t.float "ph"
    t.date "date_mise_au_sel"
    t.date "date_sortie_de_sel"
    t.integer "durée_fumage"
    t.float "poids_sortie_sèche"
    t.date "date_entrée_affinage"
    t.date "date_sortie_affinage_vente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantité", default: 0
    t.index ["porc_id"], name: "index_coppas_on_porc_id"
  end

  create_table "lonzus", force: :cascade do |t|
    t.bigint "porc_id", null: false
    t.integer "numéro_lot"
    t.float "poids"
    t.float "epaisseur_lard"
    t.float "ph"
    t.date "date_mise_au_sel"
    t.date "date_sortie_de_sel"
    t.integer "durée_fumage"
    t.float "poids_sortie_sèche"
    t.date "date_entrée_affinage"
    t.date "date_sortie_affinage_vente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantité", default: 0
    t.index ["porc_id"], name: "index_lonzus_on_porc_id"
  end

  create_table "porcs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "boucle"
    t.string "boucle_mère"
    t.string "boucle_père"
    t.date "date_de_naissance"
    t.string "sexe"
    t.float "poids"
    t.date "date_décès"
    t.boolean "abattu", default: false
    t.bigint "abattage_id"
    t.float "poids_carcasse"
    t.float "epaisseur_lard"
    t.float "ph"
    t.boolean "eligible_AOP", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "décès", default: false
    t.boolean "vermifuge_2_mois", default: false
    t.boolean "vermifuge_6_mois", default: false
    t.boolean "vermifuge_12_mois", default: false
    t.bigint "coppa_id"
    t.bigint "prisuttu_id"
    t.bigint "lonzu_id"
    t.index ["abattage_id"], name: "index_porcs_on_abattage_id"
    t.index ["coppa_id"], name: "index_porcs_on_coppa_id"
    t.index ["lonzu_id"], name: "index_porcs_on_lonzu_id"
    t.index ["prisuttu_id"], name: "index_porcs_on_prisuttu_id"
    t.index ["user_id"], name: "index_porcs_on_user_id"
  end

  create_table "prisuttus", force: :cascade do |t|
    t.bigint "porc_id", null: false
    t.integer "numéro_lot"
    t.float "poids"
    t.float "epaisseur_lard"
    t.float "ph"
    t.date "date_mise_au_sel"
    t.date "date_sortie_de_sel"
    t.integer "durée_fumage"
    t.float "poids_sortie_sèche"
    t.date "date_entrée_affinage"
    t.date "date_sortie_affinage_vente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantité", default: 0
    t.index ["porc_id"], name: "index_prisuttus_on_porc_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nom"
    t.string "prénom"
    t.string "EDE"
    t.string "adresse"
    t.integer "code_postal"
    t.string "ville"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coppas", "porcs"
  add_foreign_key "lonzus", "porcs"
  add_foreign_key "porcs", "abattages"
  add_foreign_key "porcs", "coppas"
  add_foreign_key "porcs", "lonzus"
  add_foreign_key "porcs", "prisuttus"
  add_foreign_key "porcs", "users"
  add_foreign_key "prisuttus", "porcs"
end
