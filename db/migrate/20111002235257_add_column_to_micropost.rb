class AddColumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :weight, :Integer
  end
end
