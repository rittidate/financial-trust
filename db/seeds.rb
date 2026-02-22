# db/seeds.rb
User.destroy_all

user1 = User.find_or_create_by!(name: "Praew") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end

user2 = User.find_or_create_by!(name: "Mugk") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end

user3 = User.find_or_create_by!(name: "Oat") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end


admin = User.find_or_create_by!(name: "Admin") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.admin = true
end

savings1 = SavingsAccount.find_or_create_by!(user: user1) do |acc|
  acc.balance = 0
  acc.interest_rate = 0.0
end

SavingsAccount.find_or_create_by!(user: user2) do |acc|
  acc.balance = 0
  acc.interest_rate = 0.0
end

SavingsAccount.find_or_create_by!(user: user3) do |acc|
  acc.balance = 0
  acc.interest_rate = 0.0
end

investing1 = InvestingAccount.find_or_create_by!(user: admin) do |acc|
  acc.balance = 0
  acc.interest_rate = 3.0
end

investing2 = InvestingAccount.find_or_create_by!(user: admin) do |acc|
  acc.balance = 0
  acc.interest_rate = 3.0
end

investing3 = InvestingAccount.find_or_create_by!(user: admin) do |acc|
  acc.balance = 0
  acc.interest_rate = 3.0
end

# Share the investing account with other users
investing1.users << user1 unless investing1.users.include?(user1)
investing2.users << user2 unless investing1.users.include?(user2)
investing3.users << user3 unless investing1.users.include?(user3)



# # Create initial ledger entry for consistency
# if investing.ledger_entries.empty? && investing.balance > 0
#   LedgerEntry.create!(
#     account: investing,
#     amount: investing.balance,
#     entry_type: 'transfer_in'
#   )
# end

puts "Seeed Data Created:"
puts "User: #{user1.name} (password: password)"
puts "Admin: #{admin.name} (password: password)"
puts "Savings: #{savings1.balance.to_f}"
puts "Investing: #{investing1.balance.to_f}"
