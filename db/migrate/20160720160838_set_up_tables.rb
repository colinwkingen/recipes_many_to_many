class SetUpTables < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:indgredients, :string)
      t.column(:instruction, :string)
      t.column(:rating, :int)
    end

    create_table(:categories) do |t|
      t.column(:name, :string)
    end

    create_table(:categories_recipes) do |t|
      t.column(:category_id, :int)
      t.column(:recipe_id, :int)
    end
  end
end
