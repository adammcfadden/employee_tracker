class CreateDivisions < ActiveRecord::Migration
  def change
    create_table(:tasks) do |t|
      t.column(:name, :string)
    end
  end
end
