# db/seeds.rb
User.destroy_all

user = User.find_or_create_by!(name: "Alice") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end

admin = User.find_or_create_by!(name: "Admin") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.admin = true
end

savings = SavingsAccount.find_or_create_by!(user: user) do |acc|
  acc.balance = 1000
  acc.interest_rate = 0.0
end

investing = InvestingAccount.find_or_create_by!(user: user) do |acc|
  acc.balance = 0
  acc.interest_rate = 0.0
end

puts "Seeed Data Created:"
puts "User: #{user.name} (password: password)"
puts "Admin: #{admin.name} (password: password)"
puts "Savings: #{savings.balance.to_f}"
puts "Investing: #{investing.balance.to_f}"
