class ChangeColorTableToHsl < ActiveRecord::Migration
  def change
  	change_table :colors do |t|
  		t.rename :r, :h
  		t.rename :g, :s
  		t.rename :b, :l
  	end
  end
end
