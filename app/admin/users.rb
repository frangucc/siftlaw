ActiveAdmin.register User do
  actions :all, :except => [:new]

  index do
    column :name
    column :email
    default_actions
  end
  
  filter :name
  filter :email
  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
