class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verifica_senha, only: [:update]
  before_action :set_admin, only: [:edit, :update]

  def index
  	@admins = Admin.all
  end

  def edit
  end

  def update
	if @admin.update(ajustar_parametros)
		redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
	else
		render :edit
	end
  end



  private

  def ajustar_parametros
  	params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
  	@admin = Admin.find(params[:id])
  end

  def verifica_senha
  	if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
  	   params[:admin].extract!(:password, :password_confirmation)
  	end
  end

end
