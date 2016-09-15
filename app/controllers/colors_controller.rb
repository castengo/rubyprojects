class ColorsController < ApplicationController
	before_action :set_color, only: [:show]
	#get colors
	def index

		case params[:product_type]
		when "Eyes"
	      @shades = Color.joins(:products).where(:products => { :product_type => ["Eye Shadow Palette", "Eye Shadow Single"]} ).order(:l)
	    when "Lips"
	    	@shades = Color.joins(:products).where(:products => { :product_type => "Lipstick" } ).order(:l)
	      # Lipstick
	    when "Face"
				# Blushes
			when nil
    		@colors = Color.all.order(:l)
				@red_yellow_colors = Color.where(h: 8..60).order(:l, :s, :h)
				@green_colors = Color.where(h: 61..156).order(:l, :s, :h)
				@blue_colors = Color.where(h: 157..252).order(:l, :s, :h)
				@purple_pink_colors = Color.where(h: 253..324).order(:l, :s, :h)
				@pink_red_colors = Color.where(h: [325..360] + [1..7]).order(:l, :s, :h)

				#testing browns
				# @light_colors = Color.where(l: 80..100).order(:l, :s, :h)
				@browns = Color.where(h: 3..25, s: 1..55).order(:l, :s, :h)
				# @browns = Color.where("colors.h BETWEEN 3 AND 23 AND (colors.s BETWEEN 1 AND 50 OR (colors.l BETWEEN 1 AND 45)").order(:l, :s, :h)
				@oranges = Color.where(h: 3..25, s: 56..100).order(:l, :s, :h)
				@not_browns = Color.where.not(:id => @browns.pluck(:id) + @oranges.pluck(:id)).order(:l, :s, :h)
	    end

	    respond_to do |format|
	      format.html
	      format.js
	    end

	end

	def show
		@spot_on_colors = Color.close_colors(@color,10,5,2)
		@close_call_colors = Color.close_colors(@color,30,20,10).where.not(id: @spot_on_colors.pluck(:id)).limit(9)
	end

	private

	def set_color
		@color = Color.find(params[:id])
	end

end
