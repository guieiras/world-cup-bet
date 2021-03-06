# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_05_014949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "league_invites", force: :cascade do |t|
    t.string "email"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inviter_id"
    t.bigint "league_id"
    t.index ["email"], name: "index_league_invites_on_email"
    t.index ["inviter_id"], name: "index_league_invites_on_inviter_id"
    t.index ["league_id"], name: "index_league_invites_on_league_id"
  end

  create_table "league_participations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "league_id"
    t.index ["league_id"], name: "index_league_participations_on_league_id"
    t.index ["user_id", "league_id"], name: "index_league_participations_on_user_id_and_league_id", unique: true
    t.index ["user_id"], name: "index_league_participations_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_leagues_on_creator_id"
    t.index ["uuid"], name: "index_leagues_on_uuid", unique: true
  end

  create_table "matchdays", force: :cascade do |t|
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_score"
    t.integer "away_score"
    t.integer "home_penalty"
    t.integer "away_penalty"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "home_team_id"
    t.bigint "away_team_id"
    t.bigint "stadium_id"
    t.bigint "matchday_id"
    t.integer "code"
    t.string "stage"
    t.boolean "finished"
    t.string "match_type"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["matchday_id"], name: "index_matches_on_matchday_id"
    t.index ["stadium_id"], name: "index_matches_on_stadium_id"
  end

  create_table "prediction_results", force: :cascade do |t|
    t.boolean "home_score"
    t.boolean "away_score"
    t.boolean "game_winner"
    t.boolean "penalty_winner"
    t.boolean "match_winner"
    t.boolean "score_difference"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prediction_id", null: false
    t.boolean "penalty_result"
    t.index ["prediction_id"], name: "index_prediction_results_on_prediction_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.integer "home_score"
    t.integer "away_score"
    t.integer "home_penalty"
    t.integer "away_penalty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "match_id"
    t.index ["match_id"], name: "index_predictions_on_match_id"
    t.index ["user_id"], name: "index_predictions_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "stadiums", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "fifa_code"
    t.string "flag_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.datetime "confirmed_at"
    t.string "email_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["email_token"], name: "index_users_on_email_token", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "league_invites", "leagues"
  add_foreign_key "league_invites", "users", column: "inviter_id"
  add_foreign_key "league_participations", "leagues"
  add_foreign_key "league_participations", "users"
  add_foreign_key "leagues", "users", column: "creator_id"
  add_foreign_key "matches", "matchdays"
  add_foreign_key "matches", "stadiums"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "prediction_results", "predictions"
  add_foreign_key "predictions", "matches"
  add_foreign_key "predictions", "users"
end
