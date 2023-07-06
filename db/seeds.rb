# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create minimal setup to be able to login
customer = Customer.create!(url: "localhost",
                            language: "en",
                            max_power_user: 20,
                            max_simple_user: 100,
                            freemium: false,
                            comment: "Development Customer")

DependencyFactoryService.create!(customer)
customer.reload

customer.flag.update(improver: true,
                     risk_module: true,
                     migration: false,
                     graph_steps: false,
                     sso: true,
                     ldap: true,
                     renaissance: false,
                     store: true)

User.create!(customer: customer,
             email: "sarahkerrigan@pyx4.com",
             lastname: "Kerrigan",
             firstname: "Sarah",
             password: "Qual1ps0_V2",
             profile_type: "user",
             improver_profile_type: "user")
manager = User.create!(customer: customer,
                       email: "jamesraynor@pyx4.com",
                       lastname: "Raynor",
                       firstname: "James",
                       password: "Qual1ps0_V2",
                       profile_type: "designer",
                       improver_profile_type: "manager")
admin = User.create!(customer: customer,
                     owner: true,
                     email: "developer@pyx4.com",
                     lastname: "Pyx4",
                     firstname: "Developer",
                     password: "qualipso",
                     profile_type: "admin",
                     language: "en",
                     improver_profile_type: "admin")

# Risk rights
admin.assign_pyx4_module_responsibility(:risk_module, :admin)
manager.assign_pyx4_module_responsibility(:risk_module, :manager)

customer.add_risk_owner(admin)

# Include a user from another customer
customer = Customer.create!(freemium: false,
                            url: "pyx4.pyx4.com",
                            comment: "Test Pyx4 customer")

DependencyFactoryService.create!(customer)
customer.reload

customer.flag.update(improver: true,
                     risk_module: true,
                     migration: false,
                     graph_steps: false,
                     sso: false,
                     renaissance: false,
                     store: true)
User.create!(customer: customer,
             email: "alpha@pyx4.com",
             lastname: "Centauri",
             firstname: "Alpha",
             password: "Abcd123456",
             profile_type: "admin",
             improver_profile_type: "admin")
