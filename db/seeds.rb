User.create!([
  {email: "clonaldo@gmail.com", password: "123456789", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 46, current_sign_in_at: "2016-06-16 06:49:08", last_sign_in_at: "2016-06-16 06:08:34", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: "7M41yEgj35o3unS_kL7B", confirmed_at: "2016-05-31 21:44:51", confirmation_sent_at: "2016-05-31 21:44:33", unconfirmed_email: nil, failed_attempts: 0, unlock_token: nil, locked_at: nil, first_name: "Jorge", last_name: "Cook", user_name: "jecook", role: 3},
  {email: "bill.cook@atpalcanada.com", password: "cotufito1", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2016-06-11 11:03:07", last_sign_in_at: "2016-06-11 04:08:52", current_sign_in_ip: "::1", last_sign_in_ip: "::1", confirmation_token: "1ac9BGT8UYTz_r_HbpE7", confirmed_at: "2016-06-11 03:08:32", confirmation_sent_at: "2016-06-11 03:07:38", unconfirmed_email: nil, failed_attempts: 0, unlock_token: nil, locked_at: nil, first_name: "Guillermo", last_name: "Cook", user_name: "cotufito", role: 3},
])
Adulthood.create!([
  {name: "Minor"},
  {name: "Adult"},
  {name: "Not defined"},
  {name: "Twin adult"}
])
Promo.create!([
  {description: "30% Discount of International prices.", number: "0.3", percentage: "30%", type_of_promo: "Special rebate", valid_until: "2016-06-30"},
  {description: "8 to 11 weeks, receive 1 week free\r\n\r\n10 to 22 weeks, receive 2 weeks free Valid until: April 30, 2016\r\n\r\n23+ receive 3 weeks free", number: nil, percentage: "", type_of_promo: "Special", valid_until: "2016-07-31"},
  {description: "15% Japan discount", number: "0.15", percentage: "15%", type_of_promo: "Special rebate", valid_until: "2016-08-31"},
  {description: "25% Rebate Promo 2016", number: "0.25", percentage: "25%", type_of_promo: "Special rebate", valid_until: "2016-08-31"},
  {description: "20% Korea discount", number: "0.2", percentage: "20%", type_of_promo: "Rebate", valid_until: "2016-10-31"},
  {description: "No promo", number: "0.0", percentage: "0", type_of_promo: "None", valid_until: "2026-06-30"},
  {description: "Prueba", number: "0.0", percentage: "0", type_of_promo: "None", valid_until: nil}
])
Region.create!([
  {name: "Venezuela"},
  {name: "Latin America"},
  {name: "Mexico"},
  {name: "Korea"},
  {name: "Japan"},
  {name: "International"},
  {name: "Europe"},
  {name: "Brazil"}
])
Accommodation.create!([
  {type_of_accommodation: "Homestay / 2 meals  (Adult)", cost: "210.0", adulthood_id: 2},
  {type_of_accommodation: "Homestay / 2 meals (Minor)", cost: "230.0", adulthood_id: 1},
  {type_of_accommodation: "Homestay / 2 meals (Twin)", cost: "180.0", adulthood_id: 4},
  {type_of_accommodation: "Homestay / 3 meals (Adult)", cost: "230.0", adulthood_id: 2},
  {type_of_accommodation: "Homestay / 3 meals (Minor)", cost: "260.0", adulthood_id: 1},
  {type_of_accommodation: "Homestay / 3 meals (Twin)", cost: "200.0", adulthood_id: 4},
  {type_of_accommodation: "Roomstay (Adult)", cost: "160.0", adulthood_id: 2},
  {type_of_accommodation: "Roomstay (twin)", cost: "125.0", adulthood_id: 4},
  {type_of_accommodation: "Student House (Adult)", cost: "180.0", adulthood_id: 2},
  {type_of_accommodation: "Student House (Twin)", cost: "150.0", adulthood_id: 4},
  {type_of_accommodation: "Homestay / 2 meals (Adult - Korea)", cost: "188.0", adulthood_id: 2},
  {type_of_accommodation: "Homestay / 2 meals (Minor - Korea)", cost: "219.0", adulthood_id: 1},
  {type_of_accommodation: "Homestay / 2 meals (Twin - Korea)", cost: "165.0", adulthood_id: 4},
  {type_of_accommodation: "Homestay / 3 meals (Adult - Korea)", cost: "193.0", adulthood_id: 2},
  {type_of_accommodation: "Homestay / 3 meals (Minor - korea)", cost: "243.0", adulthood_id: 1},
  {type_of_accommodation: "Homestay / 3 meals (Twin - Korea)", cost: "170.0", adulthood_id: 4},
  {type_of_accommodation: "None", cost: "0.0", adulthood_id: 3}
])
Program.create!([
  {title: "Intensive Training", cost: "380.0", lessons_per_week: 30, time_table: nil},
  {title: "Mothers plan", cost: "280.0", lessons_per_week: 22, time_table: nil},
  {title: "Language Booster I", cost: nil, lessons_per_week: 12, time_table: nil},
  {title: "Language Booster II", cost: nil, lessons_per_week: 8, time_table: nil}
])
Week.create!([
  {number: "1 to 11", cost: "380.0", program_id: 1},
  {number: "12 to 23", cost: "360.0", program_id: 1},
  {number: "24 to 31", cost: "342.0", program_id: 1},
  {number: "32+", cost: "324.0", program_id: 1},
  {number: "1 to 23", cost: "160.0", program_id: 3},
  {number: "24+", cost: "140.0", program_id: 3},
  {number: "1 to 23", cost: "99.0", program_id: 4},
  {number: "24+", cost: "89.0", program_id: 4}
])
Hour.create!([
  {number: 25, program_id: 1},
  {number: 20, program_id: 2},
  {number: 8, program_id: 3},
  {number: 4, program_id: 4}
])
FixedDurationProgram.create!([
  {name: "TOEFL and IELTS", duration_weeks: 3, cost: "500.0", total_after_promos: nil, time_table: "Monday-Tuesday-Thursday 3:00pm – 5:00pm"},
  {name: "DELF and TEFaQ", duration_weeks: 3, cost: "500.0", total_after_promos: nil, time_table: "Monday-Tuesday-Thursday 3:00pm – 5:00pm"},
  {name: "ACADEMIC FRENCH", duration_weeks: 3, cost: "500.0", total_after_promos: nil, time_table: "Monday-Tuesday-Thursday 3:00pm – 5:00pm"},
  {name: "ACADEMIC  ENGLISH", duration_weeks: 3, cost: "500.0", total_after_promos: nil, time_table: "Monday-Tuesday-Thursday 3:00pm – 5:00pm"}
])

Agency.create!([
  {name: "Careback", country: "Korea", address: "", phone_number: "", email: "canada100100@hanmail.net", commission: ""},
  {name: "E.W Network", country: "Korea", address: "", phone_number: "", email: "briankim0403@gmail.com", commission: ""},
  {name: "Eleaders", country: "Korea", address: "", phone_number: "", email: "fss@fsskorea.com", commission: ""},
  {name: "ELK", country: "Korea", address: "", phone_number: "", email: "elkedu.korea@gmail.com", commission: ""},
  {name: "GS ConsultingGroups LTD", country: "Korea", address: "", phone_number: "", email: "gsmontreal.edu@gmail.com", commission: ""},
  {name: "International Acadamy Inc", country: "Korea", address: "", phone_number: "", email: "iamontreal@iacanada.com", commission: ""},
  {name: "IAE Edu Net", country: "Korea", address: "", phone_number: "", email: "iae.adm.coco@eduhouse.net", commission: ""},
  {name: "Hyundai Dream Study", country: "Korea", address: "", phone_number: "", email: "sm8898@hanmail.net", commission: ""},
  {name: "J&J Study Abroad", country: "Korea", address: "", phone_number: "", email: "jnjseoul2@hanmail.net", commission: ""},
  {name: "Woori", country: "Korea", address: "", phone_number: "", email: "sophia@woori.ca", commission: ""},
  {name: "K12", country: "Korea", address: "", phone_number: "", email: "k-12@rcanada.co.kr", commission: ""},
  {name: "KimoKran", country: "Korea", address: "", phone_number: "", email: "kimokranmontreal@gmail.com", commission: ""},
  {name: "Seoul Fashion College", country: "Korea", address: "", phone_number: "", email: "mde3543@naver.com", commission: ""},
  {name: "Jinos", country: "Korea", address: "", phone_number: "", email: "accounting@jinos.com", commission: ""},
  {name: "UhakLab", country: "Korea", address: "", phone_number: "", email: "uhaklab@uhaklab.com", commission: ""},
  {name: "Gamja Uhak", country: "Korea", address: "", phone_number: "", email: "admin@gamjauhak.com", commission: ""},
  {name: "Yaeldam", country: "Korea", address: "", phone_number: "", email: "info@yaedalm.net", commission: ""},
  {name: "Uhakdotcom", country: "Korea", address: "", phone_number: "", email: "biz@uhak.com", commission: ""},
  {name: "UhakWiz-W", country: "Korea", address: "", phone_number: "", email: "info15@uhakwiz-w.com", commission: ""},
  {name: "Brand New Way", country: "Japan", address: "", phone_number: "", email: "montreal@bnwjp.com", commission: ""},
  {name: "Chikara", country: "Japan", address: "", phone_number: "", email: "chikarayokota@gmail.com", commission: ""},
  {name: "HEKI Canada", country: "Japan", address: "", phone_number: "", email: "Info@heki.ca", commission: ""},
  {name: "JP Canada", country: "Japan", address: "", phone_number: "", email: "ai@jpcanada.com", commission: ""},
  {name: "QL Seeker", country: "Japan", address: "", phone_number: "", email: "info@qlseducation.com", commission: ""},
  {name: "Ryugaku Johokan", country: "Japan", address: "", phone_number: "", email: "tomomi@ryugaku-johokan.com", commission: ""},
  {name: "Ryugaku Information Center", country: "Japan", address: "", phone_number: "", email: "funada@ryugaku-johokan.com", commission: ""},
  {name: "Hitomi", country: "Japan", address: "", phone_number: "", email: "desk14@triplefirst.com", commission: ""},
  {name: "Janlink", country: "Japan", address: "", phone_number: "", email: "local@janlink.ca", commission: ""}
])
Contact.create!([
  {name: "Ai ", last_name: "Nakano", email_address: "ai@jpcanada.com", phone_number: "", position: "", branch: "", agency_id: 25},
  {name: "Tomomi ", last_name: "Otani", email_address: "tomomi@ryugaku-johokan.com", phone_number: "", position: "", branch: "", agency_id: 27},
  {name: "Julia", last_name: "", email_address: "canada100100@hanmail.net", phone_number: "", position: "Sales", branch: "", agency_id: 1},
  {name: "EunJi ", last_name: "Kim", email_address: "ew_ejkim@naver.com", phone_number: "", position: "", branch: "", agency_id: 2},
  {name: "Cathy", last_name: "Park", email_address: "ew.cathy1105@gmail.com", phone_number: "", position: "", branch: "", agency_id: 2},
  {name: "Brian ", last_name: "Kim", email_address: "briankim0403@gmail.com", phone_number: "5149342580", position: "", branch: "", agency_id: 2},
  {name: "Eddie ", last_name: "Seo", email_address: "fss@fsskorea.com", phone_number: "", position: "", branch: "", agency_id: 3},
  {name: "Annie ", last_name: "Baek", email_address: "fss@fsskorea.com", phone_number: "", position: "", branch: "", agency_id: 3},
  {name: "Jerry ", last_name: "Kim", email_address: "fss@fsskorea.com", phone_number: "", position: "President", branch: "", agency_id: 3},
  {name: "BoKyung ", last_name: "Kim", email_address: "elkedu.korea@gmail.com", phone_number: "", position: "", branch: "", agency_id: 4},
  {name: "Ryan ", last_name: "Mok", email_address: "ryan.gsmontreal@gmail.com", phone_number: "", position: "", branch: "", agency_id: 5},
  {name: "Dana", last_name: "", email_address: "gsmontreal.edu@gmail.com", phone_number: "", position: "", branch: "", agency_id: 5},
  {name: "Dawoon ", last_name: "Jung", email_address: "iamontreal@iacanada.com", phone_number: "", position: "", branch: "", agency_id: 6},
  {name: "Eunice ", last_name: "Park", email_address: "iatoronto@iacanada.com", phone_number: "", position: "", branch: "", agency_id: 6},
  {name: "Inseong (Henny)", last_name: "Hong ", email_address: "ishong@eduhouse.net", phone_number: "", position: "", branch: "", agency_id: 7},
  {name: "Coco ", last_name: "Song", email_address: "iae.adm.coco@eduhouse.net", phone_number: "82-70-4865-5908, 82-2-3481-1217", position: "", branch: "", agency_id: 7},
  {name: "Jade ", last_name: "Kim", email_address: "jhk@eduhouse.net", phone_number: "", position: "", branch: "", agency_id: 7},
  {name: "Joseph ", last_name: "Choi", email_address: "choikh@eduhouse.net", phone_number: "", position: "", branch: "", agency_id: 7},
  {name: "Sumy ", last_name: "Kim", email_address: "sm8898@hanmail.net", phone_number: "82-42-825-5982", position: "", branch: "", agency_id: 8},
  {name: "Bosung ", last_name: "Kang", email_address: "jnjseoul2@hanmail.net", phone_number: "82-2-598-5572", position: "", branch: "", agency_id: 9},
  {name: "Sophia ", last_name: "Kim", email_address: "sophia@woori.ca", phone_number: "82-234747043", position: "", branch: "", agency_id: 10},
  {name: "Darlene", last_name: "", email_address: "k-12@rcanada.co.kr", phone_number: "82-2-532-6224 ", position: "", branch: "", agency_id: 11},
  {name: "EunJu", last_name: "", email_address: "kimokranmontreal@gmail.com", phone_number: "", position: "", branch: "", agency_id: 12},
  {name: "Mayet ", last_name: "Oh", email_address: "mde3543@naver.com", phone_number: "82.10.2243.2685", position: "", branch: "", agency_id: 13},
  {name: "Soo", last_name: "", email_address: "accounting@jinos.com", phone_number: "02-477-5283", position: "", branch: "", agency_id: 14},
  {name: "Cho", last_name: "Il young", email_address: "uhaklab@uhaklab.com", phone_number: "", position: "", branch: "", agency_id: 15},
  {name: "Sunny ", last_name: "Kim", email_address: "admin@gamjauhak.com", phone_number: "", position: "", branch: "", agency_id: 16},
  {name: "Wook ", last_name: "Lak", email_address: "info@yaedalm.net", phone_number: "", position: "", branch: "", agency_id: 17},
  {name: "Julia ", last_name: "Hong", email_address: "biz@uhak.com", phone_number: "", position: "", branch: "", agency_id: 18},
  {name: "Chris ", last_name: "Yoo", email_address: "info15@uhakwiz-w.com", phone_number: "", position: "", branch: "", agency_id: 19},
  {name: "Kazuho", last_name: "", email_address: "kazuho@bnwjp.com", phone_number: "", position: "Sales", branch: "", agency_id: 20},
  {name: "Junko ", last_name: "Kimura", email_address: "account@bnwjp.com", phone_number: "", position: "Accounting", branch: "", agency_id: 20},
  {name: "Megumi ", last_name: "Fujimora", email_address: "montreal@bnwjp.com", phone_number: "", position: "Sales", branch: "", agency_id: 20},
  {name: "Chikara ", last_name: "Yokota", email_address: "chikarayokota@gmail.com", phone_number: "", position: "", branch: "", agency_id: 21},
  {name: "Sayaka ", last_name: "Sakakibara", email_address: "Info@heki.ca", phone_number: "", position: "", branch: "", agency_id: 22},
  {name: "Ai", last_name: "Nakano", email_address: "ai@jpcanada.com", phone_number: "", position: "", branch: "", agency_id: 23},
  {name: "Miyuki", last_name: "", email_address: "mkawashima@qlseeker.ca", phone_number: "", position: "Sales", branch: "", agency_id: 24},
  {name: "Chie ", last_name: "Funada", email_address: "funada@ryugaku-johokan.com", phone_number: "", position: "", branch: "", agency_id: 26}
])
