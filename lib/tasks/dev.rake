namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      
      mostrar("Apagando  BD...") {%x(rails db:drop)}
      mostrar("Criando   BD...") {%x(rails db:create)}
      mostrar("Migrando  BD...") {%x(rails db:migrate)}
      mostrar("Criando Admin padrão...") {%x(rails dev:add_admin)}
      mostrar("Criando Admin extras...") {%x(rails dev:add_admins_extras)}
      mostrar("Criando User padrão...") {%x(rails dev:add_user)}
      mostrar("Cadastrando assuntos padrões...") {%x(rails dev:add_subjects)}
      mostrar("Cadastrando perguntas e respostas...") {%x(rails dev:add_answers_and_questions)}
      
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

  desc "Adiciona assuntos padrões"
    task add_subjects: :environment do
    file_name = 'subject.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip) # strip tira \r, \t, \n e espaços
    end
  end

  desc "Adiciona perguntas e respostas"
    task add_answers_and_questions: :environment do
      Subject.all.each do |subject|
        rand(5..10).times do |i|
          params = create_question_params(subject)
          answers_array = params[:question][:answers_attributes]
          add_answers(answers_array)
          selec_true_answer(answers_array)
          Question.create!(params[:question])
        end
      end
  end

  private

  def mostrar(inicio, fim = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{inicio}")
    spinner.auto_spin
    yield
    spinner.success("(#{fim})")
  end

  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(
        create_answer_params
      )
    end
  end

  def selec_true_answer(answers_array = [])
    selected_index = rand(answers_array.size)
    answers_array[selected_index] = create_answer_params(true)
  end

  def create_question_params(subject = Subject.all.sample) #caso não venha nenhum parametro ele sorteia um do model
    { question: {
            description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
            subject: subject,
            answers_attributes: []
          }
    }
  end

  def create_answer_params(correto = false)
    {description: Faker::Lorem.sentence, correct: correto}
  end

end
