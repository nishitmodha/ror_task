ActiveAdmin.register Student do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :email, :password, :password_confirmation, :reset_password_token, :reset_password_sent_at, :remember_created_at, :date_of_birth, :address, :verified
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :date_of_birth, :address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    import_data_errors = Student.import(params[:dump][:file])
    if import_data_errors.present?
      flash[:alert] = import_data_errors
      redirect_to :action => :index
    else
      flash[:notice] = "CSV imported successfully"
      redirect_to :action => :index
    end
  end
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :date_of_birth
    column :address
    column :verified
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :address
      f.input :date_of_birth
      f.input :verified
    end
    f.actions
  end
  
end
