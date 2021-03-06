require 'highline/import'

# see last line where we create an admin if there is none, asking for email and password
def prompt_for_admin_password
  if ENV['ADMIN_PASSWORD']
    password = ENV['ADMIN_PASSWORD'].dup
    say "Admin Password #{password}"
  else
    password = ask('Password [gesmew123]: ') do |q|
      q.echo = false
      q.validate = /^(|.{5,40})$/
      q.responses[:not_valid] = 'Invalid password. Must be at least 5 characters long.'
      q.whitespace = :strip
    end
    password = 'gesmew123' if password.blank?
  end

  password
end

def prompt_for_admin_email
  if ENV['ADMIN_EMAIL']
    email = ENV['ADMIN_EMAIL'].dup
    say "Admin User #{email}"
  else
    email = ask('Email [mjgumbs.200@gmail.com]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    email = 'mjgumbs.200@gmail.com' if email.blank?
  end

  email
end

def prompt_for_admin_firstname
  if ENV['ADMIN_FIRSTNAME']
    firstname = ENV['ADMIN_FIRSTNAME'].dup
    say "Admin User #{firstname}"
  else
    firstname = ask('First Name [Michail]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    firstname = 'Michail' if firstname.blank?
  end

  firstname
end

def prompt_for_admin_lastname
  if ENV['ADMIN_LASTNAME']
    lastname = ENV['ADMIN_LASTNME'].dup
    say "Admin User #{lastname}"
  else
    lastname = ask('Last Name [Gumbs]: ') do |q|
      q.echo = true
      q.whitespace = :strip
    end
    lastname = 'Gumbs' if lastname.blank?
  end

  lastname
end


def create_admin_user
  if ENV['AUTO_ACCEPT']
    password = 'gesmew123'
    email = 'mjgumbs.200@gmail.com'
    firstname 'Michail'
    lastname 'Gumbs'
  else
    puts 'Create the admin user (press enter for defaults).'
    #name = prompt_for_admin_name unless name
    email = prompt_for_admin_email
    password = prompt_for_admin_password
    firstname = prompt_for_admin_firstname
    lastname = prompt_for_admin_lastname
  end
  attributes = {
    :password => password,
    :password_confirmation => password,
    :firstname => firstname,
    :lastname => lastname,
    :email => email,
    :login => email
  }

  load 'gesmew/user.rb'

  if Gesmew::User.find_by_email(email)
    say "\nWARNING: There is already a user with the email: #{email}, so no account changes were made.  If you wish to create an additional admin user, please run rake gesmew_auth:admin:create again with a different email.\n\n"
  else
    admin = Gesmew::User.new(attributes)
    if admin.save
      role = Gesmew::Role.find_or_create_by(name: 'admin')
      admin.gesmew_roles << role
      admin.save
      admin.generate_gesmew_api_key!
      say "Done!"
    else
      say "There was some problems with persisting new admin user:"
      admin.errors.full_messages.each do |error|
        say error
      end
    end
  end
end

if Gesmew::User.admin.empty?
  create_admin_user
else
  puts 'Admin user has already been previously created.'
  if agree('Would you like to create a new admin user? (yes/no)')
    create_admin_user
  else
    puts 'No admin user created.'
  end
end
