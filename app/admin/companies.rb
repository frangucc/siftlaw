ActiveAdmin.register Company do
  #actions :all, :except => [:new]
  index do
    column :name
    column :primary_category
    column :budget
    column :about
    column :city
    column :state
    column "User" do |company|
      company.user.name
    end
    default_actions
  end
  
  filter :name
  filter :primary_category, as: :select, collection: Common.categories
  filter :budget, as: :select, collection: Common.budgets
  filter :about
  filter :city
  filter :state, as: :select, collection: StateCity.states
  filter :address

  form do |f|
    f.inputs "Company Details" do
      f.input :name
      f.input :primary_category, collection: Common.categories
      f.input :budget, collection: Common.budgets
      f.input :about
      f.input :city
      f.input :state, collection: StateCity.states
      f.input :address
      f.input :website
      f.input :phone
    end
    f.buttons
  end
end
