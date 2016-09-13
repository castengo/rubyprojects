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
				@red_yellow_colors = Color.where(h: 8..60).order(:l)
				@green_colors = Color.where(h: 61..156).order(:l, :s, :h)
				@blue_colors = Color.where(h: 157..252).order(:l, :s, :h)
				@purple_pink_colors = Color.where(h: 253..324).order(:l, :s, :h)
				@pink_red_colors = Color.where(h: [325..360] + [1..7]).order(:l, :s, :h)
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
