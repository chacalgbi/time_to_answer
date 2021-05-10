class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
  	@subjects = Subject.all.order(:description).page(params[:page])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(ajustar_parametros)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Cadastrado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
  	if @subject.update(ajustar_parametros)
  		redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área atualizado com sucesso!"
  	else
  		render :edit
  	end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área excluido com sucesso!"
    else
      render :index
    end    
  end

  private

  def ajustar_parametros
  	params.require(:subject).permit(:description)
  end

  def set_subject
  	@subject = Subject.find(params[:id])
  end

end
