class AddStartStopDatesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :start_date, :date
    add_column :pages, :end_date, :date
  end
end
