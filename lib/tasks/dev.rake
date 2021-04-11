namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      
      mostrar("Apagando  BD...") {%x(rails db:drop)}
      mostrar("Criando   BD...") {%x(rails db:create)}
      mostrar("Migrando  BD...") {%x(rails db:migrate)}
      mostrar("Criando Admin padrão...") {%x(rails dev:add_admin)}
      mostrar("Criando Admin extras...") {%x(rails dev:add_admins_extras)}
      mostrar("Criando User padrão...") {%x(rails dev:add_user)}
      
    else
      puts "Você não está no modo desenvolvimento"      
    end
  end

  desc "Adiciona o administrador padrão"
  task add_admin: :environment do
  Admin.create!(
  email: 'admin@admin.com',
  password: DEFAULT_PASSWORD,
  password_confirmation: DEFAULT_PASSWORD
  )
  end

  desc "Adiciona administradores extras"
  task add_admins_extras: :environment do
    10.times do |i| 
      Admin.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_user: :environment do
  User.create!(
  email: 'user@user.com',
  password: DEFAULT_PASSWORD,
  password_confirmation: DEFAULT_PASSWORD
  )
  end

  private
  def mostrar(inicio, fim = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{inicio}")
    spinner.auto_spin
    yield
    spinner.success("(#{fim})")
  end

end
